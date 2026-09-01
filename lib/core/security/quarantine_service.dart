class QuarantineRecord {
  const QuarantineRecord({
    required this.reason,
    required this.traceId,
    required this.data,
    required this.quarantinedAt,
  });

  final String reason;
  final String traceId;
  final Map<String, dynamic> data;
  final DateTime quarantinedAt;
}

class QuarantineService {
  final List<QuarantineRecord> records = <QuarantineRecord>[];

  Future<void> quarantine({
    required String reason,
    required String traceId,
    required Map<String, dynamic> data,
  }) async {
    records.add(
      QuarantineRecord(
        reason: reason,
        traceId: traceId,
        data: Map<String, dynamic>.from(data),
        quarantinedAt: DateTime.now(),
      ),
    );
  }
}
