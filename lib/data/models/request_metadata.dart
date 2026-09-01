import 'package:habot/core/constants/api_constants.dart';

class RequestMetadata {
  const RequestMetadata({required this.traceId, required this.logicHash});

  final String traceId;
  final String logicHash;

  Map<String, String> toHeaders() {
    return <String, String>{
      ApiConstants.contentTypeHeader: ApiConstants.jsonContentType,
      ApiConstants.traceIdHeader: traceId,
      ApiConstants.logicHashHeader: logicHash,
    };
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiConstants.traceIdHeader: traceId,
      ApiConstants.logicHashHeader: logicHash,
    };
  }
}
