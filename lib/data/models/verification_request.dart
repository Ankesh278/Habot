import 'package:habot/core/constants/api_constants.dart';
import 'package:habot/data/models/lsa_profile_model.dart';
import 'package:habot/data/models/request_metadata.dart';

class VerificationRequest {
  const VerificationRequest({required this.profile, required this.metadata});

  final LsaProfileModel profile;
  final RequestMetadata metadata;

  String get traceId => metadata.traceId;
  String get logicHash => metadata.logicHash;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ...profile.toJson(),
      ApiConstants.metadataKey: metadata.toJson(),
    };
  }
}
