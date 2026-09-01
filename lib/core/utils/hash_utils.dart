import 'dart:convert';

import 'package:crypto/crypto.dart';

class HashUtils {
  HashUtils._();

  static String sha256Hash(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }
}
