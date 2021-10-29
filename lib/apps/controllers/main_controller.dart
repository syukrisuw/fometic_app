import 'package:flutter/material.dart';
import 'package:fometic_app/apps/services/camera_services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainController extends GetxController with WidgetsBindingObserver {
  final String title = 'Main Title';
  var tabIndex = 2;
  var allowWriteFile = false;
  CameraServices cameraServices = Get.find<CameraServices>();

  PersistentTabController tabController =  PersistentTabController(initialIndex: 0);

  @override
  void onInit() {
    print("[MainController.onInit]");
    super.onInit();
    requestWritePermission();
  }

  @override
  void onClose() {
    print("[MainController.onClose]");
    cameraServices.camController!.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("[EventController.didChangeAppLifecycleState]");
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

  requestWritePermission() async {
    if (await Permission.storage.request().isGranted) {
      print(Permission.storage.status.toString());
      // Either the permission was already granted before or the user just granted it.
    }
    if (await Permission.manageExternalStorage.request().isGranted) {
      print(Permission.manageExternalStorage.status.toString());
      // Either the permission was already granted before or the user just granted it.
    }

// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.manageExternalStorage,
      Permission.storage,
    ].request();
    print(statuses[Permission.manageExternalStorage]);
    print(statuses[Permission.storage]);
  }


  void onTabItemSelected(int index) {
    print("[MainController.onTabItemSelected] index=${index}");
    CameraServices cameraServices = Get.find<CameraServices>();

    if(cameraServices.isRecordingInProgress) {
      cameraServices.stopVideoRecording();
    }

/*
    if(index==2){
      print("eventController.isCameraInitialized=${eventController.isCameraInitialized.toString()}");
      histController.isCameraInitialized = false;
      if (eventController.isCameraInitialized) {
        eventController.initCamera().whenComplete(()=> {eventController.onNewCameraSelected(eventController.cameras[0], true)});
      }

    }else if(index==3){
      print("histController.isCameraInitialized=${eventController.isCameraInitialized.toString()}");
      eventController.isCameraInitialized = false;
      if (histController.isCameraInitialized) {
        histController.initCamera().whenComplete(()=> {
          print("histController.initCamera completed"),
          histController.onNewCameraSelected(histController.cameras[0], true)
        });
      }
    }
    */

  }


}