import 'package:flutter/material.dart';
import 'package:habot/core/constants/app_dimensions.dart';
import 'package:habot/core/constants/app_strings.dart';
import 'package:habot/core/extensions/context_extensions.dart';
import 'package:habot/core/theme/app_colors.dart';
import 'package:habot/shared/widgets/app_card.dart';
import 'package:habot/shared/widgets/app_outlined_button.dart';

class DemoControlsByt extends StatelessWidget {
  const DemoControlsByt({
    super.key,
    required this.onValidSubmission,
    required this.onMissingLineage,
    required this.onFailClosed,
    required this.enabled,
  });

  final VoidCallback onValidSubmission;
  final VoidCallback onMissingLineage;
  final VoidCallback onFailClosed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.border)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                AppStrings.demoOnlyLabel,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ),
            const Expanded(child: Divider(color: AppColors.border)),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingMd),
        AppCard(
          color: AppColors.demoSurface,
          borderColor: AppColors.demoBorder,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppStrings.demoControlsTitle,
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                AppStrings.demoControlsCaption,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppOutlinedButton(
                label: AppStrings.validSubmission,
                onPressed: enabled ? onValidSubmission : null,
              ),
              const SizedBox(height: 4),
              Text(
                AppStrings.validSubmissionHint,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppOutlinedButton(
                label: AppStrings.missingLineage,
                onPressed: enabled ? onMissingLineage : null,
              ),
              const SizedBox(height: 4),
              Text(
                AppStrings.missingLineageHint,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppOutlinedButton(
                label: AppStrings.failClosed,
                onPressed: enabled ? onFailClosed : null,
              ),
              const SizedBox(height: 4),
              Text(
                AppStrings.failClosedHint,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
