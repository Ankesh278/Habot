import 'package:flutter/services.dart';

abstract final class AppInputFormatters {
  static final name = [
    FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z '\-]")),
  ];

  static final phone = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s\-()]')),
  ];

  static final identifier = [
    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9\-_]')),
  ];
}
