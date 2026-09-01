import 'package:habot/core/constants/api_constants.dart';
import 'package:habot/data/models/api_status.dart';
import 'package:habot/data/models/verification_request.dart';
import 'package:habot/data/models/verification_response.dart';
import 'package:habot/data/services/api_client.dart';

class VerificationApiService {
  VerificationApiService(this._client);

  final ApiClient _client;

  ApiStatus get scenario => _client.scenario;

  set scenario(ApiStatus value) => _client.scenario = value;

  bool get didDispatch => _client.didDispatch;

  void resetDispatchFlag() => _client.resetDispatchFlag();

  Future<VerificationResponse> verify(VerificationRequest request) async {
    final response = await _client.post(
      ApiConstants.verifyProfilePath,
      data: request.toJson(),
      metadata: request.metadata,
    );
    final raw = response.data;
    return VerificationResponse.fromJson(
      raw is Map<String, dynamic> ? raw : null,
    );
  }
}
