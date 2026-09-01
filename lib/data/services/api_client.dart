import 'package:dio/dio.dart';
import 'package:habot/core/constants/api_constants.dart';
import 'package:habot/data/models/api_status.dart';
import 'package:habot/data/models/request_metadata.dart';

class ApiClient {
  ApiClient(this.dio) {
    dio.interceptors.add(InterceptorsWrapper(onRequest: _simulateBackend));
  }

  final Dio dio;

  ApiStatus scenario = ApiStatus.success;
  bool didDispatch = false;
  Map<String, dynamic>? lastPayload;
  Map<String, String>? lastHeaders;

  void resetDispatchFlag() {
    didDispatch = false;
    lastPayload = null;
    lastHeaders = null;
  }

  Future<Response<dynamic>> post(
    String endpoint, {
    required Map<String, dynamic> data,
    required RequestMetadata metadata,
  }) {
    final headers = metadata.toHeaders();
    didDispatch = true;
    lastPayload = data;
    lastHeaders = headers;
    return dio.post<dynamic>(
      endpoint,
      data: data,
      options: Options(headers: headers),
    );
  }

  void _simulateBackend(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    switch (scenario) {
      case ApiStatus.success:
        handler.resolve(
          Response<dynamic>(
            requestOptions: options,
            statusCode: 200,
            data: <String, dynamic>{
              ApiConstants.successKey: true,
              ApiConstants.verificationIdKey: _requestVerificationId(options),
            },
          ),
        );
      case ApiStatus.invalidResponse:
        handler.resolve(
          Response<dynamic>(
            requestOptions: options,
            statusCode: 200,
            data: <String, dynamic>{
              ApiConstants.successKey: true,
              ApiConstants.verificationIdKey: null,
            },
          ),
        );
      case ApiStatus.serverError:
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: Response<dynamic>(
              requestOptions: options,
              statusCode: 500,
              data: <String, dynamic>{
                ApiConstants.errorKey: ApiConstants.internalServerError,
              },
            ),
          ),
        );
    }
  }

  String? _requestVerificationId(RequestOptions options) {
    final data = options.data;
    if (data is Map<String, dynamic>) {
      final value = data[ApiConstants.verificationIdKey];
      return value is String ? value : null;
    }
    if (data is Map) {
      final value = data[ApiConstants.verificationIdKey];
      return value is String ? value : null;
    }
    return null;
  }
}
