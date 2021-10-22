import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'apps/pages/app_pages.dart';
import 'apps/routes/app_routes.dart';
import 'utils/themes/app_theme.dart';

void main() {
  runApp(FometicApp());
}

class FometicApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.MAIN,
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}