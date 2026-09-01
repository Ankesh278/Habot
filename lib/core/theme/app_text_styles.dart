import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static TextTheme apply(TextTheme base) {
    return base.copyWith(
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        fontSize: 20,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        fontSize: 15,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        fontSize: 13,
      ),
      labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      bodyMedium: base.bodyMedium?.copyWith(height: 1.35),
      bodySmall: base.bodySmall?.copyWith(height: 1.35),
    );
  }

  static const button = TextStyle(fontWeight: FontWeight.w600, fontSize: 15);

  static TextStyle? caption(TextTheme textTheme, Color color) {
    return textTheme.bodySmall?.copyWith(color: color);
  }

  static TextStyle? mono(TextTheme textTheme) {
    return textTheme.bodySmall?.copyWith(
      fontFamily: 'monospace',
      letterSpacing: -0.2,
    );
  }
}
