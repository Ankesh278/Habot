import 'package:habot/core/errors/app_exception.dart';

class FailClosedException extends AppException {
  const FailClosedException(
    super.message, {
    super.traceId,
    this.reasonCode = 'fail_closed',
  });

  final String reasonCode;
}
