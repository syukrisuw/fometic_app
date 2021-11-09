import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fometic_app/main.dart';
import 'package:get/get.dart';

class CameraServices extends GetxService {
  CameraController? cameraController;
  List<CameraDescription> cameraDescriptionList = [];
  bool isCameraMounted = false;
  bool isCameraInitialized = false;
  bool isCameraControllerInitialized = false;
  bool isRecordingVideoInProgress = false;
  bool isRecordingVideoPaused = false;
  int selectedCameraIdx = 0;
  bool isCameraServiceReady = false;

  @override
  void onInit() {
    print("[CameraServices.onInit]");
    super.onInit();
    WidgetsFlutterBinding.ensureInitialized();
    _initDefaultCameraAndController();
  }

  @override
  void onReady() {
    print("[CameraServices.onReady]");
    isCameraServiceReady = true;
  }

  void _initDefaultCameraAndController() {
    isCameraInitialized = false;
    try {
      _initDeviceCameraDescriptionList();
      _initCameraController(cameraDescriptionList[0], ResolutionPreset.medium);
      isCameraInitialized = true;
    } on Exception catch (_, e) {
      print("[]_initDefaultCameraController Error $e");
    }
  }

  void _initDeviceCameraDescriptionList() {
    availableCameras().then((deviceCameraList) {
      cameraDescriptionList = deviceCameraList;
      print(
          "[CameraServices.checkAvailableCamera]Available camera : $cameraDescriptionList.length");

      if (cameraDescriptionList.length > 0) {
        selectedCameraIdx = 0;
      } else {
        print(
            "[CameraServices.checkAvailableCamera]Device has no camera available");
      }
    }).catchError((error) {
      print(
          "[CameraServices.checkAvailableCamera]availableCameras method failed or device has no camera available");
    });
  }

  Future<void> _initCameraController(CameraDescription cameraDescription,
      ResolutionPreset resolutionPreset) async {
    print("[CameraServices._initCameraController]");
    //check if previous cameraController already exist
    if (cameraController != null) {
      await cameraController!.dispose(); //dispose previous cameraController
    }

    cameraController = CameraController(
      cameraDescription,
      resolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    isCameraControllerInitialized = false;
    try {
      print(
          "[CameraServices._initCameraController]Try to initialize cameraController");
      cameraController!.initialize().then((_) {
        // function is Future<void>
        print("[CameraServices._initCameraController]initilized");
        isCameraControllerInitialized = true;
      });
    } on CameraException catch (e) {
      print("[CameraServices._initCameraController]cameraController Error");
    }
  }

  List<CameraDescription> availableDeviceCamera() {
    if (cameraDescriptionList.isEmpty) {
      _initDeviceCameraDescriptionList();
    }
    return cameraDescriptionList;
  }

  void onNewCameraSelected(CameraDescription cameraDescription,
      ResolutionPreset resolutionPreset) async {
    print("[CameraServices.onNewCameraSelected]onNewCameraSelected");
    cameraController!.dispose();
    // Initialize controller
    _initCameraController(cameraDescription, resolutionPreset);
  }

  Future<void> startVideoRecording() async {
    print("[CameraServices.startVideoRecording]Setup startVideoRecording");
    if (cameraController!.value.isInitialized) {
      final CameraController tmpCameraController = cameraController!;
      if (tmpCameraController.value.isRecordingVideo) {
        // A recording has already started, do nothing.
        isRecordingVideoInProgress = true;
        print("[CameraServices.startVideoRecording]Recording on progress");
        return;
      }
      print("[CameraServices.startVideoRecording]Try to start video recording");
      try {
        tmpCameraController.startVideoRecording().then((_) {
          isRecordingVideoInProgress = true;
          print(
              "[CameraServices.startVideoRecording]isRecordingInProgress=$isRecordingVideoInProgress");
        });
      } on CameraException catch (e) {
        print(
            "[CameraServices.startVideoRecording]Error starting to record video: $e");
      }
    }
  }



  Future<XFile?> stopVideoRecording() async {
    print("[CameraServices.stopVideoRecording]Stop Video recording");
    if (cameraController!.value.isInitialized) {
      final CameraController tmpCameraController = cameraController!;
      if (!tmpCameraController.value.isRecordingVideo) {
        print("[CameraServices.stopVideoRecording]No recording in progress");
        isRecordingVideoInProgress = true;
        // Recording is already is stopped state
        return null;
      }
      try {
        XFile file = await tmpCameraController.stopVideoRecording();
        print("[CameraServices.stopVideoRecording]Recording Video Stopped");
        isRecordingVideoInProgress = false;
        return file;
      } on CameraException catch (e) {
        print(
            "[CameraServices.stopVideoRecording]Error stopping video recording: $e");
        return null;
      }

    }
  }

  Future<void> pauseVideoRecording() async {
    print("[CameraServices.pauseVideoRecording]pauseVideoRecording");
    if (cameraController!.value.isInitialized) {
      final CameraController tmpCameraController = cameraController!;
      if (!tmpCameraController.value.isRecordingVideo) {
        // Video recording is not in progress
        isRecordingVideoInProgress = false;
        isRecordingVideoPaused = false;
        print(
            "[CameraServices.pauseVideoRecording]No video recording on progress");
        return;
      }
      print("[CameraServices.pauseVideoRecording]Try to pause video recording");
      try {
        await tmpCameraController.pauseVideoRecording();
        isRecordingVideoInProgress = true;
        isRecordingVideoPaused = true;
        print("[CameraServices.pauseVideoRecording]Recording Video paused");
      } on CameraException catch (e) {
        print(
            "[CameraServices.pauseVideoRecording]Error pausing video recording: $e");
      }
    }
  }

  Future<void> resumeVideoRecording() async {
    print("[CameraServices.resumeVideoRecording]resumeVideoRecording");
    if (cameraController!.value.isInitialized) {
      final CameraController tmpCameraController = cameraController!;
      if (!tmpCameraController.value.isRecordingVideo) {
        print(
            "[CameraServices.startVideoRecording]No video recording on progress");
        return;
      }
      print(
          "[CameraServices.startVideoRecording]Try to resume video recording progress");
      try {
        await tmpCameraController!.resumeVideoRecording();
        isRecordingVideoInProgress = true;
        isRecordingVideoPaused = false;
        print("[CameraServices.startVideoRecording]Recording Video resumed");
      } on CameraException catch (e) {
        print(
            "[CameraServices.startVideoRecording]Error resuming video recording: $e");
      }
    }
  }
  
}
