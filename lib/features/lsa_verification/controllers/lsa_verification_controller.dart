import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habot/core/constants/app_constants.dart';
import 'package:habot/core/constants/app_strings.dart';
import 'package:habot/core/errors/fail_closed_exception.dart';
import 'package:habot/core/security/compliance_gate.dart';
import 'package:habot/core/security/lineage_validator.dart';
import 'package:habot/core/security/metadata_generator.dart';
import 'package:habot/core/security/quarantine_service.dart';
import 'package:habot/core/utils/validators.dart';
import 'package:habot/data/models/lsa_profile_model.dart';
import 'package:habot/data/models/api_status.dart';
import 'package:habot/data/models/verification_request.dart';
import 'package:habot/data/models/verification_status.dart';
import 'package:habot/data/repositories/verification_repository.dart';
import 'package:habot/friction/friction_event.dart';
import 'package:habot/friction/friction_tracker.dart';
import 'package:habot/shared/widgets/app_toast.dart';

class LsaVerificationController extends GetxController {
  LsaVerificationController({
    required this.repository,
    required this.quarantineService,
    FrictionTracker? frictionTracker,
  }) : frictionTracker = frictionTracker ?? FrictionTracker();

  final VerificationRepository repository;
  final QuarantineService quarantineService;
  final FrictionTracker frictionTracker;

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final verificationIdController = TextEditingController();
  final predecessorIdController = TextEditingController();

  final isSubmitting = false.obs;
  final status = VerificationStatus.ready.obs;
  final errorMessage = RxnString();
  final lastTraceId = RxnString();
  final lastLogicHash = RxnString();
  final apiDispatched = false.obs;
  final frictionEvents = <FrictionEvent>[].obs;
  final lastQuarantineReason = RxnString();

  String? _activeFrictionField;

  @override
  void onClose() {
    frictionTracker.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    verificationIdController.dispose();
    predecessorIdController.dispose();
    super.onClose();
  }

  void onFieldInteraction(String fieldId) {
    if (_activeFrictionField != fieldId) {
      frictionTracker.start(
        fieldId: fieldId,
        onFrictionDetected: _onFrictionDetected,
      );
      _activeFrictionField = fieldId;
      return;
    }
    frictionTracker.interaction();
  }

  void _onFrictionDetected() {
    frictionEvents.assignAll(List<FrictionEvent>.from(frictionTracker.events));
  }

  LsaProfileModel _readProfile() {
    return LsaProfileModel(
      fullName: fullNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      verificationId: verificationIdController.text,
      predecessorId: predecessorIdController.text,
    );
  }

  Future<void> submitVerification() async {
    if (isSubmitting.value) {
      return;
    }

    formKey.currentState?.validate();

    errorMessage.value = null;
    lastQuarantineReason.value = null;
    lastLogicHash.value = null;
    apiDispatched.value = false;
    repository.resetDispatchFlag();

    status.value = VerificationStatus.validating;
    final profile = _readProfile();
    final traceId = MetadataGenerator.createTraceId();
    lastTraceId.value = traceId;

    if (!LineageValidator.isValid(profile.predecessorId)) {
      await _stopClosed(
        reason: AppStrings.missingLineageMessage,
        traceId: traceId,
        data: profile.toJson(),
        userMessage: AppStrings.missingLineageMessage,
      );
      return;
    }

    final compliance = ComplianceGate.validate(profile);
    if (!compliance.isCompliant) {
      await _stopClosed(
        reason: compliance.reason ?? AppStrings.complianceFailureMessage,
        traceId: traceId,
        data: profile.toJson(),
        userMessage: AppStrings.complianceFailureMessage,
      );
      return;
    }

    final metadata = MetadataGenerator.create(traceId: traceId);
    lastLogicHash.value = metadata.logicHash;
    final request = VerificationRequest(profile: profile, metadata: metadata);

    isSubmitting.value = true;
    status.value = VerificationStatus.submitting;
    try {
      await repository.verify(request);
      apiDispatched.value = repository.didDispatch;
      status.value = VerificationStatus.submitted;
      errorMessage.value = null;
      _resetFormFields();
      _notify(
        AppStrings.submittedToastTitle,
        AppStrings.submittedToastBody,
      );
    } on FailClosedException catch (error) {
      apiDispatched.value = repository.didDispatch;
      await _stopClosed(
        reason: error.message,
        traceId: traceId,
        data: request.toJson(),
        userMessage: AppStrings.invalidResponseMessage,
      );
    } catch (_) {
      apiDispatched.value = repository.didDispatch;
      status.value = VerificationStatus.failed;
      errorMessage.value = AppStrings.networkFailureMessage;
      _notify(
        AppStrings.submissionFailedTitle,
        AppStrings.networkFailureMessage,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> _stopClosed({
    required String reason,
    required String traceId,
    required Map<String, dynamic> data,
    required String userMessage,
  }) async {
    await quarantineService.quarantine(
      reason: reason,
      traceId: traceId,
      data: data,
    );
    lastQuarantineReason.value = reason;
    apiDispatched.value = repository.didDispatch;
    isSubmitting.value = false;
    status.value = VerificationStatus.quarantined;
    errorMessage.value = userMessage;
    _notify(AppStrings.quarantinedToastTitle, userMessage);
  }

  Future<void> runValidSubmission() async {
    _fillValidProfile();
    repository.scenario = ApiStatus.success;
    await submitVerification();
  }

  Future<void> runMissingLineage() async {
    _fillValidProfile();
    predecessorIdController.text = '';
    repository.scenario = ApiStatus.success;
    await submitVerification();
  }

  Future<void> runFailClosed() async {
    _fillValidProfile();
    repository.scenario = ApiStatus.invalidResponse;
    await submitVerification();
  }

  void _resetFormFields() {
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
    verificationIdController.clear();
    predecessorIdController.clear();
    formKey.currentState?.reset();
  }

  void _fillValidProfile() {
    errorMessage.value = null;
    formKey.currentState?.reset();
    fullNameController.text = AppConstants.demoFullName;
    emailController.text = AppConstants.demoEmail;
    phoneController.text = AppConstants.demoPhone;
    verificationIdController.text = AppConstants.demoVerificationId;
    predecessorIdController.text = AppConstants.demoPredecessorId;
  }

  void _notify(String title, String message) {
    AppToast.show(message, title: title);
  }

  String? validateFullName(String? value) => AppValidators.fullName(value);

  String? validateEmail(String? value) => AppValidators.email(value);

  String? validatePhone(String? value) => AppValidators.phone(value);

  String? validateVerificationId(String? value) =>
      AppValidators.verificationId(value);

  String? validatePredecessorId(String? value) =>
      AppValidators.predecessorId(value);
}
