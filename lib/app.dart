import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habot/core/constants/app_strings.dart';
import 'package:habot/core/theme/app_theme.dart';
import 'package:habot/routes/app_routes.dart';
import 'package:habot/shared/widgets/app_toast.dart';

class HabotApp extends StatelessWidget {
  const HabotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.lsaVerification,
      getPages: AppRoutes.pages,
      builder: (context, child) {
        return AppToastHost(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
