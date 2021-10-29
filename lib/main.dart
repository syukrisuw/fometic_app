import 'package:flutter/material.dart';
import 'package:fometic_app/apps/services/camera_services.dart';
import 'package:fometic_app/utils/file_helper.dart';
import 'package:get/get.dart';

import 'apps/pages/app_pages.dart';
import 'apps/routes/app_routes.dart';
import 'apps/services/file_services.dart';
import 'utils/themes/app_theme.dart';

Future<void> main() async {
  await initServices();
  runApp(FometicApp());
}

Future<void> initServices() async {
  print("[Main.initServices]>>>Initialize all services");

  await Get.putAsync(() => CameraServices().init() );
  await Get.putAsync(() => FileServices().init() );
  await Get.putAsync(() => FileHelperServices().init() );

  print("[Main.initServices]>>>Done initilizing all services");
}


class FometicApp extends StatelessWidget with WidgetsBindingObserver{

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("[EventController.didChangeAppLifecycleState]");
    CameraServices cameraServices = Get.find<CameraServices>();

    if (cameraServices.camController == null || !cameraServices.isCameraInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraServices.camController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (cameraServices.camController != null) {
        cameraServices.onNewCameraSelected(cameraServices.cameras[0], true);
      }
    }
    super.didChangeAppLifecycleState(state);
  }

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