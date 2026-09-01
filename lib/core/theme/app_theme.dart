import 'package:flutter/material.dart';
import 'package:habot/core/theme/app_button_styles.dart';
import 'package:habot/core/theme/app_card_styles.dart';
import 'package:habot/core/theme/app_colors.dart';
import 'package:habot/core/theme/app_input_styles.dart';
import 'package:habot/core/theme/app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.light,
    );
    return _base(
      scheme: scheme,
      scaffoldBackground: AppColors.background,
      appBarForeground: AppColors.textPrimary,
      cardTheme: AppCardStyles.light(),
      inputTheme: AppInputStyles.light(),
    );
  }

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.dark,
    );
    return _base(
      scheme: scheme,
      scaffoldBackground: scheme.surface,
      appBarForeground: scheme.onSurface,
      cardTheme: AppCardStyles.dark(scheme),
      inputTheme: AppInputStyles.dark(scheme),
    );
  }

  static ThemeData _base({
    required ColorScheme scheme,
    required Color scaffoldBackground,
    required Color appBarForeground,
    required CardThemeData cardTheme,
    required InputDecorationTheme inputTheme,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffoldBackground,
      textTheme: AppTextStyles.apply(
        ThemeData(brightness: scheme.brightness).textTheme,
      ),
      visualDensity: VisualDensity.compact,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 52,
        backgroundColor: scaffoldBackground,
        foregroundColor: appBarForeground,
        titleTextStyle: TextStyle(
          color: appBarForeground,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
      ),
      cardTheme: cardTheme,
      inputDecorationTheme: inputTheme,
      filledButtonTheme: FilledButtonThemeData(style: AppButtonStyles.filled()),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: AppButtonStyles.outlined(),
      ),
    );
  }
}
