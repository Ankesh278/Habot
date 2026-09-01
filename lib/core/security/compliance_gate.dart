import 'package:habot/core/constants/app_constants.dart';
import 'package:habot/core/utils/validators.dart';
import 'package:habot/data/models/lsa_profile_model.dart';

class ComplianceResult {
  const ComplianceResult.passed() : isCompliant = true, reason = null;

  const ComplianceResult.failed(this.reason) : isCompliant = false;

  final bool isCompliant;
  final String? reason;
}

class ComplianceGate {
  ComplianceGate._();

  static ComplianceResult validate(LsaProfileModel profile) {
    if (AppValidators.fullName(profile.fullName) != null) {
      return const ComplianceResult.failed(AppConstants.fieldFullName);
    }
    if (AppValidators.email(profile.email) != null) {
      return const ComplianceResult.failed(AppConstants.fieldEmail);
    }
    if (AppValidators.phone(profile.phone) != null) {
      return const ComplianceResult.failed(AppConstants.fieldPhone);
    }
    if (AppValidators.verificationId(profile.verificationId) != null) {
      return const ComplianceResult.failed(AppConstants.fieldVerificationId);
    }
    if (AppValidators.predecessorId(profile.predecessorId) != null) {
      return const ComplianceResult.failed(AppConstants.fieldPredecessorId);
    }
    return const ComplianceResult.passed();
  }
}
