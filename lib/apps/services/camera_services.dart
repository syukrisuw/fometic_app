import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraServices extends GetxService {

  CameraController? camController;
  List<CameraDescription> cameras = [];
  bool isCameraMounted = false;
  bool isCameraInitialized = false;
  bool isRecordingInProgress = false;


  Future<void> init() async {
    try {
      print('[CameraServices.initCamera]>>>Try create cameras description');
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      print('[CameraServices.initCamera]>>>Error in fetching the cameras: $e');
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription, bool mounted) async {
    print("[CameraServices.onNewCameraSelected]onNewCameraSelected");
    final previousCameraController = camController;

    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.low,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      camController = cameraController;
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) {
        isCameraMounted = true;
      }
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the boolean
    if (mounted) {
      isCameraInitialized = camController!.value.isInitialized;
    }
  }

  Future<void> startVideoRecording() async {
    print("[CameraServices.startVideoRecording]Setup startVideoRecording");
    final CameraController? cameraController = camController;
    if (camController!.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      print("[CameraServices.startVideoRecording]Recording on progress");
      return;
    }
    try {
      await cameraController!.startVideoRecording();
      isRecordingInProgress = true;
      print("[CameraServices.startVideoRecording]Try to start video recording");
    } on CameraException catch (e) {
      print("[CameraServices.startVideoRecording]Error starting to record video: $e");
    }
  }

  Future<XFile?> stopVideoRecording() async {
    print("[CameraServices.stopVideoRecording]Stop Video recording");
    if (!camController!.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }
    try {
      XFile file = await camController!.stopVideoRecording();
      isRecordingInProgress = false;
      print("[CameraServices.stopVideoRecording]isRecordingInProgress=${isRecordingInProgress}");
      return file;
    } on CameraException catch (e) {
      print("[CameraServices.stopVideoRecording]Error stopping video recording: $e");
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    print("[CameraServices.pauseVideoRecording]pauseVideoRecording");
    if (!camController!.value.isRecordingVideo) {
      // Video recording is not in progress
      print("[CameraServices.pauseVideoRecording]No video recording on progress");
      return;
    }
    try {
      print("[CameraServices.pauseVideoRecording]Try to pause video recording");
      await camController!.pauseVideoRecording();
    } on CameraException catch (e) {
      print('[CameraServices.pauseVideoRecording]Error pausing video recording: $e');
    }
  }

  Future<void> resumeVideoRecording() async {
    print("[CameraServices.resumeVideoRecording]resumeVideoRecording");
    if (!camController!.value.isRecordingVideo) {
      print("[CameraServices.startVideoRecording]Recording on progress");
      return;
    }
    try {
      print("[CameraServices.startVideoRecording]Try to resume video recording progress");
      await camController!.resumeVideoRecording();
    } on CameraException catch (e) {
      print("[CameraServices.startVideoRecording]Error resuming video recording: $e");
    }
  }

}