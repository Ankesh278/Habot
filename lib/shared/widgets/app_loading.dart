import 'package:flutter/material.dart';
import 'package:habot/core/constants/app_dimensions.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.size = AppDimensions.loadingSize,
    this.color,
  });

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: AppDimensions.strokeWidth,
        color: color,
      ),
    );
  }
}
