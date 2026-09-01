import 'package:flutter/material.dart';
import 'package:habot/core/constants/app_dimensions.dart';
import 'package:habot/core/extensions/context_extensions.dart';
import 'package:habot/core/extensions/string_extensions.dart';
import 'package:habot/core/theme/app_colors.dart';
import 'package:habot/shared/widgets/app_loading.dart';

enum AppStatusTone { ready, info, progress, success, warning, error }

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.label,
    required this.tone,
    this.caption,
    this.detail,
    this.showLoading = false,
    this.semanticsLabel,
    this.trailing,
  });

  final String label;
  final AppStatusTone tone;
  final String? caption;
  final String? detail;
  final bool showLoading;
  final String? semanticsLabel;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final palette = _palette(tone);
    return Semantics(
      label: semanticsLabel ?? label,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          border: Border.all(color: palette.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  palette.icon,
                  color: palette.foreground,
                  size: AppDimensions.statusIconSize,
                ),
                const SizedBox(width: AppDimensions.spacingSm),
                Text(
                  label,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: palette.foreground,
                  ),
                ),
                if (showLoading) ...[
                  const SizedBox(width: AppDimensions.spacingSm),
                  AppLoading(
                    size: AppDimensions.loadingSizeSm,
                    color: palette.foreground,
                  ),
                ],
                if (trailing != null) ...[const Spacer(), trailing!],
              ],
            ),
            if (caption != null) ...[
              const SizedBox(height: 4),
              Text(
                caption!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: palette.foreground,
                ),
              ),
            ],
            if (detail != null && detail!.isNotBlank) ...[
              const SizedBox(height: 4),
              Text(
                detail!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: palette.foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static _StatusPalette _palette(AppStatusTone tone) {
    switch (tone) {
      case AppStatusTone.ready:
        return const _StatusPalette(
          background: AppColors.readyContainer,
          border: AppColors.readyBorder,
          foreground: AppColors.ready,
          icon: Icons.schedule,
        );
      case AppStatusTone.info:
        return const _StatusPalette(
          background: AppColors.validatingContainer,
          border: AppColors.validatingBorder,
          foreground: AppColors.validating,
          icon: Icons.policy_outlined,
        );
      case AppStatusTone.progress:
        return const _StatusPalette(
          background: AppColors.infoContainer,
          border: AppColors.infoBorder,
          foreground: AppColors.info,
          icon: Icons.north_east,
        );
      case AppStatusTone.success:
        return const _StatusPalette(
          background: AppColors.successContainer,
          border: AppColors.successBorder,
          foreground: AppColors.success,
          icon: Icons.check_circle_outline,
        );
      case AppStatusTone.warning:
        return const _StatusPalette(
          background: AppColors.warningContainer,
          border: AppColors.warningBorder,
          foreground: AppColors.warning,
          icon: Icons.shield_outlined,
        );
      case AppStatusTone.error:
        return const _StatusPalette(
          background: AppColors.errorContainer,
          border: AppColors.errorBorder,
          foreground: AppColors.error,
          icon: Icons.error_outline,
        );
    }
  }
}

class _StatusPalette {
  const _StatusPalette({
    required this.background,
    required this.border,
    required this.foreground,
    required this.icon,
  });

  final Color background;
  final Color border;
  final Color foreground;
  final IconData icon;
}
