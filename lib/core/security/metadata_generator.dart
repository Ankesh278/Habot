import 'package:habot/core/constants/app_constants.dart';
import 'package:habot/core/utils/hash_utils.dart';
import 'package:habot/core/utils/uuid_utils.dart';
import 'package:habot/data/models/request_metadata.dart';

class MetadataGenerator {
  MetadataGenerator._();

  static String createTraceId() => UuidUtils.v4();

  static String createLogicHash() {
    return HashUtils.sha256Hash(AppConstants.canonicalLogic);
  }

  static RequestMetadata create({required String traceId}) {
    return RequestMetadata(traceId: traceId, logicHash: createLogicHash());
  }
}
