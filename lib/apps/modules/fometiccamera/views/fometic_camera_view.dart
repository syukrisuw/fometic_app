import 'package:flutter/material.dart';
import 'dart:math' as _math;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fometic_app/apps/services/camera_services.dart';

class FometicCameraView extends StatefulWidget {
  final double width;
  final double height;
  CameraServices? cameraServices;
  final previewControlPosition;

  FometicCameraView({
    required cameraServices,
    this.width = 30,
    this.height = 40,
    this.previewControlPosition = 0 //default preview only, no controller
  }); //create con

  @override
  State<FometicCameraView> createState() => _FometicCameraViewState();
}

class _FometicCameraViewState extends State<FometicCameraView> {
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _cameraPreview() {
    return (widget.cameraServices == null ||
        !widget.cameraServices!.isCameraServiceReady) ?
        AlertDialog(
        backgroundColor: Colors.redAccent,
        title: Text("CAMERA SERVICE ALERT!!!"),
        content: Text("No Camera Service Found")) :
        widget.cameraServices!.cameraController!.buildPreview() ;
  }

  Widget _leftControlPreview() {

    return Row(
      children: <Widget>[

      ],
    );
  }

  Widget _rightControlPreview() {

    return Container();
  }

  Widget _topControlPreview() {

    return Container();
  }

  Widget _bottomControlPreview() {

    return Container();
  }

  @override
  Widget build(BuildContext context) {

    return (widget.cameraServices == null ||
            !widget.cameraServices!.isCameraServiceReady)
        ? Container(
            width: widget.width,
            height: widget.height,
            child: AlertDialog(
                backgroundColor: Colors.redAccent,
                title: Text("CAMERA SERVICE ALERT!!!"),
                content: Text("No Camera Service Found")))
        : Container(
            width: widget.width,
            height: widget.height,
            child: SizedBox());
  }
}
