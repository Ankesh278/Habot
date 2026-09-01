import 'package:habot/core/constants/app_constants.dart';
import 'package:habot/core/extensions/duration_extensions.dart';

abstract final class AppStrings {
  static const appName = 'HabotConnect';

  static const verificationTitle = 'Verify LSA profile';
  static const verificationSubtitle =
      'Enter the assistant’s details, then tap Submit.';
  static const profileInformation = 'Assistant details';

  static const fullName = 'Full name';
  static const email = 'Email';
  static const phone = 'Phone number';
  static const verificationId = 'Verification ID';
  static const predecessorId = 'Predecessor ID';

  static const fullNameHint = 'e.g. Jordan Hale';
  static const emailHint = 'name@example.com';
  static const phoneHint = '+1 415 555 0100';
  static const verificationIdHint = 'e.g. VER-88421';
  static const predecessorIdHint = 'Required previous record ID';

  static const submitVerification = 'Submit';

  static const demoOnlyLabel = 'Demo only';
  static const demoControlsTitle = 'Hiring test cases';
  static const demoControlsCaption =
      'Not part of the normal form. Use these three buttons for the required video.';
  static const validSubmission = '1. Success';
  static const validSubmissionHint =
      'Fills the form and submits. Result: Verified.';
  static const missingLineage = '2. Missing ID';
  static const missingLineageHint =
      'Leaves predecessor ID empty. Result: not submitted.';
  static const failClosed = '3. Rejected';
  static const failClosedHint =
      'Submits valid details, then the reply is rejected. Result: not submitted.';

  static const ready = 'Ready';
  static const validating = 'Checking';
  static const submitting = 'Sending';
  static const submitted = 'Verified';
  static const quarantined = 'Quarantined';
  static const failed = 'Not sent';

  static const readyCaption = 'Fill in the details, then tap Submit.';
  static const validatingCaption = 'Checking the details you entered.';
  static const submittingCaption = 'Sending your verification.';
  static const submittedCaption =
      'Verification succeeded. The form is ready for the next profile.';
  static const quarantinedCaption = 'The profile was not submitted.';
  static const failedCaption = 'Submission failed. Please try again.';

  static const auditTrail = 'Request details';
  static const auditTrailCaption = 'From your last Submit.';
  static const traceIdLabel = 'Trace ID';
  static const logicHashLabel = 'Logic hash';
  static const apiRequestSentLabel = 'Request sent';
  static const quarantineLabel = 'Hold reason';
  static const frictionEvents = 'Input pauses';
  static const traceIdPending = 'Created when you submit';
  static const logicHashPending = 'Added after all checks pass';
  static const yes = 'Yes';
  static const no = 'No';
  static const requestSent = 'Sent';
  static const requestNotSent = 'Not sent';
  static const noFrictionEvents = 'No long pauses yet.';

  static const submittedToastTitle = 'Verified';
  static const submittedToastBody = 'Verification succeeded.';
  static const submissionFailedTitle = 'Not submitted';
  static const quarantinedToastTitle = 'Not submitted';

  static const missingLineageMessage =
      'Predecessor ID is required. The profile was not submitted.';
  static const complianceFailureMessage =
      'Please complete all required fields. The profile was not submitted.';
  static const invalidResponseMessage =
      'Verification could not be confirmed. Please try again.';
  static const networkFailureMessage = 'Submission failed. Please try again.';

  static const emailInvalid = 'Enter a valid email address.';
  static const emailTooLong = 'Email is too long.';
  static const fullNameTooShort = 'Enter at least 2 characters.';
  static const fullNameTooLong = 'Name is too long.';
  static const fullNameInvalid = 'Use letters and spaces only.';
  static const phoneInvalid = 'Enter a valid phone number (10–15 digits).';
  static const verificationIdInvalid =
      'Enter a valid verification ID (at least 3 characters).';
  static const predecessorIdRequired = 'Predecessor ID is required.';
  static const predecessorIdInvalid =
      'Enter a valid predecessor ID (at least 3 characters).';

  static const statusSemanticsPrefix = 'Verification status';

  static String requiredMessage(String fieldName) =>
      'Please enter ${fieldName.toLowerCase()}.';

  static String frictionEvent(String fieldId, Duration duration) =>
      '${_fieldLabel(fieldId)} was idle for ${duration.asSecondsLabel}.';

  static String statusSemantics(String label) =>
      '$statusSemanticsPrefix $label';

  static String _fieldLabel(String fieldId) {
    switch (fieldId) {
      case AppConstants.fieldFullName:
        return fullName;
      case AppConstants.fieldEmail:
        return email;
      case AppConstants.fieldPhone:
        return phone;
      case AppConstants.fieldVerificationId:
        return verificationId;
      case AppConstants.fieldPredecessorId:
        return predecessorId;
      default:
        return fieldId;
    }
  }
}
