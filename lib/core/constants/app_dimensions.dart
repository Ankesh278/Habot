import 'package:flutter/material.dart';

abstract final class AppDimensions {
  static const spacingXs = 4.0;
  static const spacingSm = 8.0;
  static const spacingMd = 12.0;
  static const spacingLg = 16.0;
  static const spacingXl = 24.0;

  static const radiusSm = 8.0;
  static const radiusMd = 10.0;
  static const radiusLg = 12.0;
  static const radiusXl = 12.0;

  static const buttonHeight = 46.0;
  static const inputHeight = 48.0;
  static const iconContainer = 36.0;
  static const loadingSize = 18.0;
  static const loadingSizeSm = 12.0;
  static const strokeWidth = 2.0;
  static const demoBorderWidth = 1.0;
  static const maxContentWidth = 640.0;
  static const pagePaddingHorizontal = 16.0;
  static const cardPadding = 16.0;
  static const statusIconSize = 18.0;
  static const fieldGap = 10.0;

  static const pagePadding = EdgeInsets.fromLTRB(
    pagePaddingHorizontal,
    spacingMd,
    pagePaddingHorizontal,
    spacingXl,
  );

  static const inputPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 12,
  );
}
