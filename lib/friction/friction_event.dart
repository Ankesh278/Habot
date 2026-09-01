import 'package:habot/core/constants/api_constants.dart';

class FrictionEvent {
  const FrictionEvent({
    required this.fieldId,
    required this.startedAt,
    required this.detectedAt,
    required this.duration,
  });

  final String fieldId;
  final DateTime startedAt;
  final DateTime detectedAt;
  final Duration duration;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiConstants.fieldIdKey: fieldId,
      ApiConstants.startedAtKey: startedAt.toIso8601String(),
      ApiConstants.detectedAtKey: detectedAt.toIso8601String(),
      ApiConstants.durationMsKey: duration.inMilliseconds,
    };
  }
}
