import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habot/core/constants/app_dimensions.dart';
import 'package:habot/core/constants/app_durations.dart';
import 'package:habot/core/theme/app_colors.dart';

class AppToastData {
  const AppToastData({required this.message, this.title});

  final String? title;
  final String message;
}

abstract final class AppToast {
  static final ValueNotifier<AppToastData?> current = ValueNotifier(null);
  static Timer? _timer;

  static void show(String message, {String? title}) {
    if (Get.testMode) {
      return;
    }

    _timer?.cancel();
    current.value = AppToastData(title: title, message: message);
    _timer = Timer(AppDurations.toastDuration, hide);
  }

  static void hide() {
    _timer?.cancel();
    _timer = null;
    current.value = null;
  }
}

class AppToastHost extends StatelessWidget {
  const AppToastHost({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        ValueListenableBuilder<AppToastData?>(
          valueListenable: AppToast.current,
          builder: (context, toast, _) {
            if (toast == null) {
              return const SizedBox.shrink();
            }
            return Positioned.fill(
              child: _AppToastCard(title: toast.title, message: toast.message),
            );
          },
        ),
      ],
    );
  }
}

class _AppToastCard extends StatelessWidget {
  const _AppToastCard({required this.message, this.title});

  final String? title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final hasTitle = title != null && title!.isNotEmpty && title != message;

    return IgnorePointer(
      child: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.pagePaddingHorizontal,
              0,
              AppDimensions.pagePaddingHorizontal,
              AppDimensions.spacingXl,
            ),
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingLg,
                      vertical: AppDimensions.spacingMd,
                    ),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.35,
                      ),
                      textAlign: TextAlign.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (hasTitle) ...[
                            Text(
                              title!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                          ],
                          Text(message),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
