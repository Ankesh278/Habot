import 'package:flutter/material.dart';
import 'package:habot/core/constants/app_strings.dart';
import 'package:habot/core/extensions/string_extensions.dart';
import 'package:habot/core/theme/app_colors.dart';
import 'package:habot/data/models/verification_status.dart';
import 'package:habot/shared/widgets/app_status_badge.dart';

class VerificationStatusByt extends StatelessWidget {
  const VerificationStatusByt({
    super.key,
    required this.status,
    this.detail,
    this.requestSent,
  });

  final VerificationStatus status;
  final String? detail;
  final bool? requestSent;

  @override
  Widget build(BuildContext context) {
    if (status == VerificationStatus.ready) {
      return const SizedBox.shrink();
    }

    final spec = _specFor(status);
    final message = (detail != null && detail!.isNotBlank)
        ? detail
        : spec.caption;

    return AppStatusBadge(
      label: spec.label,
      caption: message,
      tone: spec.tone,
      showLoading: spec.showLoading,
      semanticsLabel: AppStrings.statusSemantics(spec.label),
      trailing: requestSent == null ? null : _SentChip(sent: requestSent!),
    );
  }

  _StatusCopy _specFor(VerificationStatus value) {
    switch (value) {
      case VerificationStatus.ready:
        return const _StatusCopy(
          label: AppStrings.ready,
          caption: AppStrings.readyCaption,
          tone: AppStatusTone.ready,
        );
      case VerificationStatus.validating:
        return const _StatusCopy(
          label: AppStrings.validating,
          caption: AppStrings.validatingCaption,
          tone: AppStatusTone.info,
          showLoading: true,
        );
      case VerificationStatus.submitting:
        return const _StatusCopy(
          label: AppStrings.submitting,
          caption: AppStrings.submittingCaption,
          tone: AppStatusTone.progress,
          showLoading: true,
        );
      case VerificationStatus.submitted:
        return const _StatusCopy(
          label: AppStrings.submitted,
          caption: AppStrings.submittedCaption,
          tone: AppStatusTone.success,
        );
      case VerificationStatus.quarantined:
        return const _StatusCopy(
          label: AppStrings.quarantined,
          caption: AppStrings.quarantinedCaption,
          tone: AppStatusTone.warning,
        );
      case VerificationStatus.failed:
        return const _StatusCopy(
          label: AppStrings.failed,
          caption: AppStrings.failedCaption,
          tone: AppStatusTone.error,
        );
    }
  }
}

class _SentChip extends StatelessWidget {
  const _SentChip({required this.sent});

  final bool sent;

  @override
  Widget build(BuildContext context) {
    final color = sent ? AppColors.success : AppColors.textSecondary;
    final background = sent
        ? AppColors.successContainer
        : AppColors.readyContainer;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        sent ? AppStrings.requestSent : AppStrings.requestNotSent,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatusCopy {
  const _StatusCopy({
    required this.label,
    required this.caption,
    required this.tone,
    this.showLoading = false,
  });

  final String label;
  final String caption;
  final AppStatusTone tone;
  final bool showLoading;
}
