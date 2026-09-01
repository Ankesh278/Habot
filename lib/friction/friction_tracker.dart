import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:habot/core/constants/app_durations.dart';
import 'package:habot/friction/friction_event.dart';

class FrictionTracker {
  FrictionTracker({this.stallDuration = AppDurations.frictionThreshold});

  final Duration stallDuration;

  Timer? _timer;
  String? _fieldId;
  DateTime? _windowStartedAt;
  bool _emittedForWindow = false;
  VoidCallback? _onFrictionDetected;

  final List<FrictionEvent> events = <FrictionEvent>[];

  void start({
    required String fieldId,
    required VoidCallback onFrictionDetected,
  }) {
    _fieldId = fieldId;
    _onFrictionDetected = onFrictionDetected;
    _restartWindow();
  }

  void interaction() {
    if (_fieldId == null) {
      return;
    }
    _restartWindow();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
    _fieldId = null;
    _onFrictionDetected = null;
    events.clear();
  }

  void _restartWindow() {
    _timer?.cancel();
    _windowStartedAt = DateTime.now();
    _emittedForWindow = false;
    _timer = Timer(stallDuration, _handleStall);
  }

  void _handleStall() {
    if (_emittedForWindow || _fieldId == null || _windowStartedAt == null) {
      return;
    }
    _emittedForWindow = true;
    final detectedAt = DateTime.now();
    final event = FrictionEvent(
      fieldId: _fieldId!,
      startedAt: _windowStartedAt!,
      detectedAt: detectedAt,
      duration: detectedAt.difference(_windowStartedAt!),
    );
    events.add(event);
    _onFrictionDetected?.call();
  }
}
