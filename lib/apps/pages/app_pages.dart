import 'package:get/get.dart';
import 'package:fometic_app/apps/bindings/main_binding.dart';
import 'package:fometic_app/apps/pages/main_page.dart';

import 'package:fometic_app/apps/routes/app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.MAIN,
      page: () => MainPage(),
      binding: MainBinding(),
    ),
  ];
}