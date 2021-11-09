import 'package:flutter/material.dart';
import 'dart:math' as _math;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fometic_app/apps/modules/fometiccamera/views/fometic_camera_view.dart';
import 'package:fometic_app/apps/services/camera_services.dart';

class FometicCamera extends StatelessWidget {

  final double width;
  final double height;
  CameraServices? cameraServices;

  FometicCamera({
    required cameraServices,
    this.width = 30,
    this.height = 40,
  }); //cr

  @override
  Widget build(BuildContext context) {
    return FometicCameraView(width: width, height: height, cameraServices: cameraServices);
  }


}