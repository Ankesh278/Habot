import 'package:flutter/material.dart';
import 'package:habot/core/constants/app_dimensions.dart';
import 'package:habot/core/theme/app_colors.dart';

abstract final class AppCardStyles {
  static CardThemeData light() {
    return CardThemeData(
      elevation: 0,
      color: AppColors.surface,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        side: const BorderSide(color: AppColors.border),
      ),
    );
  }

  static CardThemeData dark(ColorScheme colors) {
    return CardThemeData(
      elevation: 0,
      color: colors.surface,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        side: BorderSide(color: colors.outlineVariant),
      ),
    );
  }
}
