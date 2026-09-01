abstract final class ApiConstants {
  static const baseUrl = 'https://api.habotconnect.local';
  static const verifyProfilePath = '/api/v1/lsa/profile/verify';

  static const contentTypeHeader = 'Content-Type';
  static const jsonContentType = 'application/json';
  static const traceIdHeader = 'trace_id';
  static const logicHashHeader = 'logic_hash';

  static const successKey = 'success';
  static const verificationIdKey = 'verification_id';
  static const metadataKey = 'metadata';
  static const errorKey = 'error';
  static const fieldIdKey = 'field_id';
  static const startedAtKey = 'started_at';
  static const detectedAtKey = 'detected_at';
  static const durationMsKey = 'duration_ms';
  static const internalServerError = 'internal_server_error';
}
