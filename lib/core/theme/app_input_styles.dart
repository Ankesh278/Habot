import 'package:flutter/material.dart';
import 'package:habot/core/constants/app_dimensions.dart';
import 'package:habot/core/theme/app_colors.dart';

abstract final class AppInputStyles {
  static InputDecorationTheme light() {
    final idle = _border(AppColors.inputBorder);
    final focused = _border(AppColors.seed, width: 1.2);
    return InputDecorationTheme(
      filled: true,
      isDense: true,
      fillColor: AppColors.inputFill,
      alignLabelWithHint: true,
      contentPadding: AppDimensions.inputPadding,
      labelStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: const TextStyle(
        color: AppColors.seed,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: const TextStyle(
        color: AppColors.error,
        fontSize: 12,
        height: 1.25,
        fontWeight: FontWeight.w500,
      ),
      errorMaxLines: 2,
      border: idle,
      enabledBorder: idle,
      disabledBorder: idle,
      focusedBorder: focused,
      errorBorder: idle,
      focusedErrorBorder: focused,
    );
  }

  static InputDecorationTheme dark(ColorScheme colors) {
    final idle = _border(colors.outline);
    final focused = _border(colors.primary, width: 1.2);
    return InputDecorationTheme(
      filled: true,
      isDense: true,
      fillColor: colors.surfaceContainerHighest,
      alignLabelWithHint: true,
      contentPadding: AppDimensions.inputPadding,
      errorStyle: TextStyle(
        color: colors.error,
        fontSize: 12,
        height: 1.25,
        fontWeight: FontWeight.w500,
      ),
      errorMaxLines: 2,
      border: idle,
      enabledBorder: idle,
      disabledBorder: idle,
      focusedBorder: focused,
      errorBorder: idle,
      focusedErrorBorder: focused,
    );
  }

  static OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
