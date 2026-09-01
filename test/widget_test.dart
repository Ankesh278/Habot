import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habot/app.dart';
import 'package:habot/core/constants/app_strings.dart';
import 'package:habot/features/lsa_verification/views/lsa_profile_verification_screen.dart';
import 'package:habot/features/lsa_verification/widgets/verification_field_byt.dart';
import 'package:habot/shared/widgets/app_button.dart';

void main() {
  testWidgets('loads the LSA verification screen as a StatelessWidget', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const HabotApp());
    await tester.pumpAndSettle();

    expect(find.byType(LsaProfileVerificationScreen), findsOneWidget);
    expect(find.text(AppStrings.verificationTitle), findsOneWidget);
    expect(find.byType(VerificationFieldByt), findsNWidgets(5));
    expect(find.byType(AppButton), findsOneWidget);
    expect(find.text(AppStrings.submitVerification), findsOneWidget);
    expect(find.text(AppStrings.demoControlsTitle), findsOneWidget);

    final screen = tester.widget<LsaProfileVerificationScreen>(
      find.byType(LsaProfileVerificationScreen),
    );
    expect(screen, isA<StatelessWidget>());
  });

  testWidgets('does not show errors on other fields while typing a name', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const HabotApp());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, AppStrings.fullName),
      'Jordan',
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.emailInvalid), findsNothing);
    expect(
      find.text(AppStrings.requiredMessage(AppStrings.email)),
      findsNothing,
    );
    expect(find.text(AppStrings.predecessorIdRequired), findsNothing);
    expect(find.text(AppStrings.phoneInvalid), findsNothing);
  });

  testWidgets('shows a field error only after that field is left invalid', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const HabotApp());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, AppStrings.email),
      'not-an-email',
    );
    await tester.tap(find.widgetWithText(TextFormField, AppStrings.fullName));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.emailInvalid), findsOneWidget);
    expect(find.text(AppStrings.predecessorIdRequired), findsNothing);
  });
}
