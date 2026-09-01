import 'package:habot/core/constants/app_strings.dart';
import 'package:habot/core/errors/fail_closed_exception.dart';
import 'package:habot/data/models/api_status.dart';
import 'package:habot/data/models/verification_request.dart';
import 'package:habot/data/models/verification_response.dart';
import 'package:habot/data/services/verification_api_service.dart';

class VerificationRepository {
  VerificationRepository(this._service);

  final VerificationApiService _service;

  ApiStatus get scenario => _service.scenario;

  set scenario(ApiStatus value) => _service.scenario = value;

  bool get didDispatch => _service.didDispatch;

  void resetDispatchFlag() => _service.resetDispatchFlag();

  Future<VerificationResponse> verify(VerificationRequest request) async {
    final response = await _service.verify(request);
    if (!response.isValid) {
      throw FailClosedException(
        AppStrings.invalidResponseMessage,
        traceId: request.traceId,
      );
    }
    return response;
  }
}
