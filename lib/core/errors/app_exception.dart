class AppException implements Exception {
  const AppException(this.message, {this.traceId});

  final String message;
  final String? traceId;

  @override
  String toString() => 'AppException($message, traceId: $traceId)';
}
