import 'package:flutter_test/flutter_test.dart';
import 'package:habot/core/constants/app_strings.dart';
import 'package:habot/core/utils/validators.dart';

void main() {
  group('AppValidators', () {
    test('required field fails on null and blank', () {
      expect(
        AppValidators.requiredField(null, AppStrings.fullName),
        AppStrings.requiredMessage(AppStrings.fullName),
      );
      expect(
        AppValidators.requiredField('  ', AppStrings.fullName),
        AppStrings.requiredMessage(AppStrings.fullName),
      );
    });

    test('required field passes on a value', () {
      expect(
        AppValidators.requiredField('Jordan Hale', AppStrings.fullName),
        isNull,
      );
    });

    test('full name rejects missing, short, long, and invalid values', () {
      expect(AppValidators.fullName(null), isNotNull);
      expect(AppValidators.fullName('A'), AppStrings.fullNameTooShort);
      expect(
        AppValidators.fullName('A' * 61),
        AppStrings.fullNameTooLong,
      );
      expect(AppValidators.fullName('Jordan123'), AppStrings.fullNameInvalid);
    });

    test('full name accepts letters, spaces, hyphens, and apostrophes', () {
      expect(AppValidators.fullName('Jordan Hale'), isNull);
      expect(AppValidators.fullName("O'Brien"), isNull);
      expect(AppValidators.fullName('Jean-Luc'), isNull);
    });

    test('email rejects missing, invalid, and overly long values', () {
      expect(AppValidators.email(null), isNotNull);
      expect(AppValidators.email('not-an-email'), AppStrings.emailInvalid);
      expect(AppValidators.email('a@b.c'), AppStrings.emailInvalid);
      expect(
        AppValidators.email('${'a' * 70}@example.com'),
        AppStrings.emailTooLong,
      );
    });

    test('email accepts a valid address', () {
      expect(AppValidators.email('jordan.hale@habotconnect.test'), isNull);
    });

    test('phone requires 10 to 15 digits', () {
      expect(AppValidators.phone(''), isNotNull);
      expect(AppValidators.phone('12345'), AppStrings.phoneInvalid);
      expect(
        AppValidators.phone('1234567890123456'),
        AppStrings.phoneInvalid,
      );
      expect(AppValidators.phone('+1 415 555 0198'), isNull);
      expect(AppValidators.phone('4155550198'), isNull);
    });

    test('verification ID requires a valid identifier', () {
      expect(AppValidators.verificationId(''), isNotNull);
      expect(AppValidators.verificationId('AB'), AppStrings.verificationIdInvalid);
      expect(AppValidators.verificationId('VER-88421'), isNull);
    });

    test('predecessor ID fails when missing or invalid', () {
      expect(
        AppValidators.predecessorId(null),
        AppStrings.predecessorIdRequired,
      );
      expect(AppValidators.predecessorId(''), AppStrings.predecessorIdRequired);
      expect(
        AppValidators.predecessorId('AB'),
        AppStrings.predecessorIdInvalid,
      );
    });

    test('predecessor ID passes when present and valid', () {
      expect(AppValidators.predecessorId('LSA-ROOT-001'), isNull);
    });
  });
}
