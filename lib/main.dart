import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fometic_app/apps/services/camera_services.dart';
import 'package:fometic_app/utils/file_helper.dart';
import 'package:get/get.dart';

import 'apps/pages/app_pages.dart';
import 'apps/routes/app_routes.dart';
import 'apps/services/file_services.dart';
import 'utils/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(FometicApp());
}

bool isCameraServiceAvailable = false;
bool isFileServiceAvailable = false;
bool isFileHelperServiceAvailable = false;

Future<void> initServices() async {
  print("[Main.initServices]>>>Initialize all services");

  await Get.putAsync<FileServices>(() async => await  FileServices() );
  isFileServiceAvailable = true;
  await Get.putAsync<FileHelperServices>(() async => await FileHelperServices() );
  isFileHelperServiceAvailable = true;
  await Get.putAsync<CameraServices>(() async => await CameraServices() );
  isCameraServiceAvailable = true;


  print("[Main.initServices]>>>Done initilizing all services");
}


class FometicApp extends StatelessWidget with WidgetsBindingObserver{

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("[EventController.didChangeAppLifecycleState]");

    // App state changed before we got the chance to initialize.
    if(isCameraServiceAvailable) {
      CameraServices cameraServices = Get.find<CameraServices>();
      if (cameraServices.cameraController == null ||
          !cameraServices.isCameraInitialized) {
        return;
      }

      if (state == AppLifecycleState.inactive) {
        cameraServices.cameraController!.dispose();
      } else if (state == AppLifecycleState.resumed) {
        if (cameraServices.cameraController != null) {
          cameraServices.onNewCameraSelected(
              cameraServices.cameraDescriptionList[0], ResolutionPreset.medium);
        }
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