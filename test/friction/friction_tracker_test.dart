import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habot/friction/friction_tracker.dart';

void main() {
  group('FrictionTracker', () {
    test('creates an event after more than 5 seconds of inactivity', () {
      fakeAsync((async) {
        var detected = 0;
        final tracker = FrictionTracker();
        tracker.start(
          fieldId: 'full_name',
          onFrictionDetected: () => detected++,
        );

        async.elapse(const Duration(seconds: 5));

        expect(detected, 1);
        expect(tracker.events, hasLength(1));
        expect(tracker.events.first.fieldId, 'full_name');

        async.elapse(const Duration(seconds: 10));
        expect(detected, 1);
      });
    });

    test('interaction resets the friction timer', () {
      fakeAsync((async) {
        var detected = 0;
        final tracker = FrictionTracker();
        tracker.start(
          fieldId: 'full_name',
          onFrictionDetected: () => detected++,
        );

        async.elapse(const Duration(seconds: 4));
        tracker.interaction();
        async.elapse(const Duration(seconds: 4));
        expect(detected, 0);

        async.elapse(const Duration(seconds: 2));
        expect(detected, 1);
        expect(tracker.events, hasLength(1));
      });
    });
  });
}
