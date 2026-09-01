import 'package:habot/core/extensions/string_extensions.dart';

extension NullableStringExtensions on String? {
  bool get isNullOrBlank => this == null || this!.isBlank;
  bool get isNotNullOrBlank => !isNullOrBlank;
}
