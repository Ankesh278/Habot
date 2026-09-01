import 'package:flutter/material.dart';
import 'package:habot/core/constants/app_dimensions.dart';
import 'package:habot/shared/widgets/app_loading.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const AppLoading()
        : (icon == null
              ? Text(label)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 20),
                    const SizedBox(width: AppDimensions.spacingSm),
                    Text(label),
                  ],
                ));

    final button = FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: child,
    );

    if (!expanded) {
      return button;
    }

    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: button,
    );
  }
}
