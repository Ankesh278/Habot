import 'package:get/get.dart';
import 'package:habot/features/lsa_verification/bindings/lsa_verification_binding.dart';
import 'package:habot/features/lsa_verification/views/lsa_profile_verification_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String lsaVerification = '/lsa-verification';

  static List<GetPage<dynamic>> get pages => <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: lsaVerification,
      page: () => const LsaProfileVerificationScreen(),
      binding: LsaVerificationBinding(),
    ),
  ];
}
