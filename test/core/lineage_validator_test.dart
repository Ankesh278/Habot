import 'package:flutter_test/flutter_test.dart';
import 'package:habot/core/security/lineage_validator.dart';

void main() {
  group('LineageValidator', () {
    test('valid predecessor_id passes', () {
      expect(LineageValidator.isValid('LSA-ROOT-001'), isTrue);
    });

    test('null predecessor_id fails', () {
      expect(LineageValidator.isValid(null), isFalse);
    });

    test('empty predecessor_id fails', () {
      expect(LineageValidator.isValid(''), isFalse);
      expect(LineageValidator.isValid('   '), isFalse);
    });
  });
}
