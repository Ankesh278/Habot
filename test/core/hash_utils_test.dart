import 'package:flutter_test/flutter_test.dart';
import 'package:habot/core/constants/app_constants.dart';
import 'package:habot/core/utils/hash_utils.dart';

void main() {
  group('HashUtils', () {
    test('known SHA-256 vector for abc', () {
      expect(
        HashUtils.sha256Hash('abc'),
        'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad',
      );
    });

    test('same canonical logic produces the same SHA-256 hash', () {
      final first = HashUtils.sha256Hash(AppConstants.canonicalLogic);
      final second = HashUtils.sha256Hash(AppConstants.canonicalLogic);
      expect(first, second);
      expect(first, hasLength(64));
    });
  });
}
