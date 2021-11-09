import 'package:flutter/material.dart';
import 'package:fometic_app/apps/models/fometic_event_model.dart';
import 'package:fometic_app/apps/models/fometic_model.dart';
import 'package:fometic_app/apps/services/camera_services.dart';
import 'package:fometic_app/apps/services/file_services.dart';
import 'package:get/get.dart';

class CameraHelperService extends GetxService {
  FileServices fileServices = Get.find<FileServices>();
  CameraServices cameraServices = Get.find<CameraServices>();



  void stopAndSaveVideoRecording() {

    cameraServices.stopVideoRecording().then((xfile) {
      if (!fileServices.isFileServicesReady) {
        fileServices.onInit();
      }

      fileServices.write

    }).onError((error, stackTrace) {
      print("[CameraServices.stopAndSaveVideoRecording]ERROR Stop Video recording");
    });


  }
}