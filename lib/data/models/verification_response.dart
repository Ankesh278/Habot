import 'package:habot/core/constants/api_constants.dart';
import 'package:habot/core/extensions/nullable_extensions.dart';

class VerificationResponse {
  const VerificationResponse({
    required this.success,
    required this.verificationId,
  });

  final bool? success;
  final String? verificationId;

  bool get isValid => success == true && verificationId.isNotNullOrBlank;

  factory VerificationResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const VerificationResponse(success: null, verificationId: null);
    }
    return VerificationResponse(
      success: json[ApiConstants.successKey] as bool?,
      verificationId: json[ApiConstants.verificationIdKey] as String?,
    );
  }
}
