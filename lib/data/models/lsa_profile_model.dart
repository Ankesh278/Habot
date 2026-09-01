import 'package:habot/core/constants/app_constants.dart';

class LsaProfileModel {
  const LsaProfileModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.verificationId,
    required this.predecessorId,
  });

  final String fullName;
  final String email;
  final String phone;
  final String verificationId;
  final String? predecessorId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      AppConstants.fieldFullName: fullName,
      AppConstants.fieldEmail: email,
      AppConstants.fieldPhone: phone,
      AppConstants.fieldVerificationId: verificationId,
      AppConstants.fieldPredecessorId: predecessorId,
    };
  }
}
