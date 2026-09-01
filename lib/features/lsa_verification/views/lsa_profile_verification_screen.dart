import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habot/core/constants/app_constants.dart';
import 'package:habot/core/constants/app_dimensions.dart';
import 'package:habot/core/constants/app_strings.dart';
import 'package:habot/core/utils/input_formatters.dart';
import 'package:habot/data/models/verification_status.dart';
import 'package:habot/features/lsa_verification/controllers/lsa_verification_controller.dart';
import 'package:habot/features/lsa_verification/widgets/demo_controls_byt.dart';
import 'package:habot/features/lsa_verification/widgets/profile_header_byt.dart';
import 'package:habot/features/lsa_verification/widgets/verification_field_byt.dart';
import 'package:habot/features/lsa_verification/widgets/verification_status_byt.dart';
import 'package:habot/shared/layouts/app_scaffold.dart';
import 'package:habot/shared/widgets/app_button.dart';
import 'package:habot/shared/widgets/app_card.dart';
import 'package:habot/shared/widgets/app_section.dart';

class LsaProfileVerificationScreen extends StatelessWidget {
  const LsaProfileVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LsaVerificationController>();

    return AppScaffold(
      title: AppStrings.appName,
      body: Obx(() {
        final submitting = controller.isSubmitting.value;
        final status = controller.status.value;
        final showResult = status != VerificationStatus.ready;

        return Form(
          key: controller.formKey,
          child: ListView(
            padding: AppDimensions.pagePadding,
            children: [
              const ProfileHeaderByt(
                title: AppStrings.verificationTitle,
                subtitle: AppStrings.verificationSubtitle,
              ),
              const SizedBox(height: AppDimensions.spacingLg),
              AppCard(
                child: AppSection(
                  title: AppStrings.profileInformation,
                  child: Column(
                    children: [
                      VerificationFieldByt(
                        label: AppStrings.fullName,
                        hint: AppStrings.fullNameHint,
                        controller: controller.fullNameController,
                        validator: controller.validateFullName,
                        enabled: !submitting,
                        maxLength: AppConstants.nameMaxLength,
                        inputFormatters: AppInputFormatters.name,
                        onInteraction: () => controller.onFieldInteraction(
                          AppConstants.fieldFullName,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.fieldGap),
                      VerificationFieldByt(
                        label: AppStrings.email,
                        hint: AppStrings.emailHint,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: controller.validateEmail,
                        enabled: !submitting,
                        maxLength: AppConstants.emailMaxLength,
                        onInteraction: () => controller.onFieldInteraction(
                          AppConstants.fieldEmail,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.fieldGap),
                      VerificationFieldByt(
                        label: AppStrings.phone,
                        hint: AppStrings.phoneHint,
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        validator: controller.validatePhone,
                        enabled: !submitting,
                        maxLength: AppConstants.phoneMaxLength,
                        inputFormatters: AppInputFormatters.phone,
                        onInteraction: () => controller.onFieldInteraction(
                          AppConstants.fieldPhone,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.fieldGap),
                      VerificationFieldByt(
                        label: AppStrings.verificationId,
                        hint: AppStrings.verificationIdHint,
                        controller: controller.verificationIdController,
                        validator: controller.validateVerificationId,
                        enabled: !submitting,
                        maxLength: AppConstants.verificationIdMaxLength,
                        inputFormatters: AppInputFormatters.identifier,
                        onInteraction: () => controller.onFieldInteraction(
                          AppConstants.fieldVerificationId,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.fieldGap),
                      VerificationFieldByt(
                        label: AppStrings.predecessorId,
                        hint: AppStrings.predecessorIdHint,
                        controller: controller.predecessorIdController,
                        textInputAction: TextInputAction.done,
                        validator: controller.validatePredecessorId,
                        enabled: !submitting,
                        maxLength: AppConstants.predecessorIdMaxLength,
                        inputFormatters: AppInputFormatters.identifier,
                        onInteraction: () => controller.onFieldInteraction(
                          AppConstants.fieldPredecessorId,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacingLg),
              AppButton(
                label: AppStrings.submitVerification,
                isLoading: submitting,
                onPressed: submitting ? null : controller.submitVerification,
              ),
              if (showResult) ...[
                const SizedBox(height: AppDimensions.spacingMd),
                VerificationStatusByt(
                  status: status,
                  detail: controller.errorMessage.value,
                  requestSent:
                      status == VerificationStatus.validating ||
                          status == VerificationStatus.submitting
                      ? null
                      : controller.apiDispatched.value,
                ),
              ],
              const SizedBox(height: AppDimensions.spacingXl),
              DemoControlsByt(
                enabled: !submitting,
                onValidSubmission: controller.runValidSubmission,
                onMissingLineage: controller.runMissingLineage,
                onFailClosed: controller.runFailClosed,
              ),
            ],
          ),
        );
      }),
    );
  }
}
