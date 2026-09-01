abstract final class AppConstants {
  static const canonicalLogic =
      'lsa_profile_verification:v1:\n'
      'full_name|required|\n'
      'email|required|email|\n'
      'phone|required|\n'
      'verification_id|required|\n'
      'predecessor_id|required|\n'
      'fail_closed:true';

  static const fieldFullName = 'full_name';
  static const fieldEmail = 'email';
  static const fieldPhone = 'phone';
  static const fieldVerificationId = 'verification_id';
  static const fieldPredecessorId = 'predecessor_id';

  static const demoFullName = 'Jordan Hale';
  static const demoEmail = 'jordan.hale@habotconnect.test';
  static const demoPhone = '+1 415 555 0198';
  static const demoVerificationId = 'VER-88421';
  static const demoPredecessorId = 'LSA-ROOT-001';

  static const nameMinLength = 2;
  static const nameMaxLength = 60;
  static const emailMaxLength = 80;
  static const phoneMinDigits = 10;
  static const phoneMaxDigits = 15;
  static const phoneMaxLength = 20;
  static const idMinLength = 3;
  static const verificationIdMaxLength = 32;
  static const predecessorIdMaxLength = 40;
}
