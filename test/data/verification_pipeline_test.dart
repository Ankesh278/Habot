import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habot/core/constants/api_constants.dart';
import 'package:habot/core/constants/app_constants.dart';
import 'package:habot/core/constants/app_strings.dart';
import 'package:habot/core/security/quarantine_service.dart';
import 'package:habot/data/models/api_status.dart';
import 'package:habot/data/models/verification_status.dart';
import 'package:habot/data/repositories/verification_repository.dart';
import 'package:habot/data/services/api_client.dart';
import 'package:habot/data/services/verification_api_service.dart';
import 'package:habot/features/lsa_verification/controllers/lsa_verification_controller.dart';

LsaVerificationController _buildController() {
  final client = ApiClient(Dio(BaseOptions(baseUrl: ApiConstants.baseUrl)));
  final repository = VerificationRepository(VerificationApiService(client));
  return LsaVerificationController(
    repository: repository,
    quarantineService: QuarantineService(),
  );
}

void _fillValid(LsaVerificationController controller) {
  controller.fullNameController.text = AppConstants.demoFullName;
  controller.emailController.text = AppConstants.demoEmail;
  controller.phoneController.text = AppConstants.demoPhone;
  controller.verificationIdController.text = AppConstants.demoVerificationId;
  controller.predecessorIdController.text = AppConstants.demoPredecessorId;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Get.testMode = true;
  });

  tearDown(Get.reset);

  test('invalid API response causes quarantine', () async {
    final controller = _buildController();
    Get.put(controller);
    _fillValid(controller);
    controller.repository.scenario = ApiStatus.invalidResponse;

    await controller.submitVerification();

    expect(controller.status.value, VerificationStatus.quarantined);
    expect(controller.apiDispatched.value, isTrue);
    expect(controller.errorMessage.value, AppStrings.invalidResponseMessage);
    expect(controller.quarantineService.records, isNotEmpty);
  });

  test('valid API response produces submitted state', () async {
    final controller = _buildController();
    Get.put(controller);
    _fillValid(controller);
    controller.repository.scenario = ApiStatus.success;

    await controller.submitVerification();

    expect(controller.status.value, VerificationStatus.submitted);
    expect(controller.apiDispatched.value, isTrue);
    expect(controller.lastTraceId.value, isNotNull);
    expect(controller.lastLogicHash.value, hasLength(64));
    expect(controller.quarantineService.records, isEmpty);
    expect(controller.fullNameController.text, isEmpty);
    expect(controller.emailController.text, isEmpty);
    expect(controller.predecessorIdController.text, isEmpty);
  });

  test('missing lineage never dispatches an API request', () async {
    final controller = _buildController();
    Get.put(controller);
    _fillValid(controller);
    controller.predecessorIdController.text = '';

    await controller.submitVerification();

    expect(controller.status.value, VerificationStatus.quarantined);
    expect(controller.apiDispatched.value, isFalse);
    expect(controller.lastLogicHash.value, isNull);
    expect(controller.errorMessage.value, AppStrings.missingLineageMessage);
  });
}
