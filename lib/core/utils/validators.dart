import 'package:habot/core/constants/app_constants.dart';
import 'package:habot/core/constants/app_strings.dart';
import 'package:habot/core/extensions/nullable_extensions.dart';
import 'package:habot/core/security/lineage_validator.dart';

abstract final class AppValidators {
  static final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
  static final namePattern = RegExp(r"^[A-Za-z]+(?:[ '\-][A-Za-z]+)*$");
  static final idPattern = RegExp(r'^[A-Za-z0-9][A-Za-z0-9\-_]*$');

  static String? requiredField(String? value, String fieldName) {
    if (value.isNullOrBlank) {
      return AppStrings.requiredMessage(fieldName);
    }
    return null;
  }

  static String? fullName(String? value) {
    final missing = requiredField(value, AppStrings.fullName);
    if (missing != null) {
      return missing;
    }
    final name = value!.trim();
    if (name.length < AppConstants.nameMinLength) {
      return AppStrings.fullNameTooShort;
    }
    if (name.length > AppConstants.nameMaxLength) {
      return AppStrings.fullNameTooLong;
    }
    if (!namePattern.hasMatch(name)) {
      return AppStrings.fullNameInvalid;
    }
    return null;
  }

  static String? email(String? value) {
    final missing = requiredField(value, AppStrings.email);
    if (missing != null) {
      return missing;
    }
    final email = value!.trim();
    if (email.length > AppConstants.emailMaxLength) {
      return AppStrings.emailTooLong;
    }
    if (!emailPattern.hasMatch(email)) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  static String? phone(String? value) {
    final missing = requiredField(value, AppStrings.phone);
    if (missing != null) {
      return missing;
    }
    final digits = value!.replaceAll(RegExp(r'\D'), '');
    if (digits.length < AppConstants.phoneMinDigits ||
        digits.length > AppConstants.phoneMaxDigits) {
      return AppStrings.phoneInvalid;
    }
    return null;
  }

  static String? verificationId(String? value) {
    final missing = requiredField(value, AppStrings.verificationId);
    if (missing != null) {
      return missing;
    }
    final id = value!.trim();
    if (id.length < AppConstants.idMinLength ||
        id.length > AppConstants.verificationIdMaxLength ||
        !idPattern.hasMatch(id)) {
      return AppStrings.verificationIdInvalid;
    }
    return null;
  }

  static String? predecessorId(String? value) {
    if (!LineageValidator.isValid(value)) {
      return AppStrings.predecessorIdRequired;
    }
    final id = value!.trim();
    if (id.length < AppConstants.idMinLength ||
        id.length > AppConstants.predecessorIdMaxLength ||
        !idPattern.hasMatch(id)) {
      return AppStrings.predecessorIdInvalid;
    }
    return null;
  }
}
