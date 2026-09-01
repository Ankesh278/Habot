import 'package:habot/core/extensions/nullable_extensions.dart';

class LineageValidator {
  LineageValidator._();

  static bool isValid(String? predecessorId) {
    return predecessorId.isNotNullOrBlank;
  }
}
