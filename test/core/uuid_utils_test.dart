import 'package:flutter_test/flutter_test.dart';
import 'package:habot/core/utils/uuid_utils.dart';

void main() {
  test('generated trace IDs are unique', () {
    final ids = <String>{
      UuidUtils.v4(),
      UuidUtils.v4(),
      UuidUtils.v4(),
      UuidUtils.v4(),
      UuidUtils.v4(),
    };
    expect(ids, hasLength(5));
  });
}
