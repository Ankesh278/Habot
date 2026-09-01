import 'package:flutter_test/flutter_test.dart';
import 'package:habot/core/security/compliance_gate.dart';
import 'package:habot/data/models/lsa_profile_model.dart';

void main() {
  group('ComplianceGate', () {
    const valid = LsaProfileModel(
      fullName: 'Jordan Hale',
      email: 'jordan.hale@habotconnect.test',
      phone: '+1 415 555 0198',
      verificationId: 'VER-88421',
      predecessorId: 'LSA-ROOT-001',
    );

    test('valid profile passes', () {
      expect(ComplianceGate.validate(valid).isCompliant, isTrue);
    });

    test('missing required field fails compliance', () {
      const missingName = LsaProfileModel(
        fullName: '',
        email: 'jordan.hale@habotconnect.test',
        phone: '+1 415 555 0198',
        verificationId: 'VER-88421',
        predecessorId: 'LSA-ROOT-001',
      );
      final result = ComplianceGate.validate(missingName);
      expect(result.isCompliant, isFalse);
      expect(result.reason, isNotNull);
    });

    test('invalid email fails compliance', () {
      const invalidEmail = LsaProfileModel(
        fullName: 'Jordan Hale',
        email: 'not-an-email',
        phone: '+1 415 555 0198',
        verificationId: 'VER-88421',
        predecessorId: 'LSA-ROOT-001',
      );
      expect(ComplianceGate.validate(invalidEmail).isCompliant, isFalse);
    });

    test('short name fails compliance', () {
      const shortName = LsaProfileModel(
        fullName: 'A',
        email: 'jordan.hale@habotconnect.test',
        phone: '+1 415 555 0198',
        verificationId: 'VER-88421',
        predecessorId: 'LSA-ROOT-001',
      );
      expect(ComplianceGate.validate(shortName).isCompliant, isFalse);
    });

    test('invalid phone fails compliance', () {
      const invalidPhone = LsaProfileModel(
        fullName: 'Jordan Hale',
        email: 'jordan.hale@habotconnect.test',
        phone: '123',
        verificationId: 'VER-88421',
        predecessorId: 'LSA-ROOT-001',
      );
      expect(ComplianceGate.validate(invalidPhone).isCompliant, isFalse);
    });
  });
}
