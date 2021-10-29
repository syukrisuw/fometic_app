import 'package:flutter/material.dart';
import 'package:fometic_app/apps/modules/actionpad/views/action_pad_compact.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:fometic_app/apps/controllers/histories_controller.dart';

class HistoriesPage extends StatelessWidget {
  TextEditingController _eventnameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoriesController>(builder: (controller) {
      return Container(
          child: SingleChildScrollView(
        key: UniqueKey(),
        physics: NeverScrollableScrollPhysics(),
        child: (Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Obx(() => Text(
                  "Event Name ${controller.event_name.value}  Total Player ${controller.total_player.value}")),
              SizedBox(
                height: 5,
              ),
              Text(
                  "Event Start Time ${controller.eventStartTime.toIso8601String()}"),
              SizedBox(
                //Camera Section
                height: 100,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 5 - 5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5 - 5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5 - 5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                        ),
                        child: controller.cameraServices.isCameraInitialized
                            ? AspectRatio(
                                aspectRatio: 1 /
                                    controller.cameraServices.camController!.value.aspectRatio,
                                child: controller.cameraServices.camController!.buildPreview(),
                              )
                            : Container(),
                      ),
                      Obx(() => (Container(
                            width: MediaQuery.of(context).size.width / 5 - 5,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                            ),
                            child: InkWell(
                              onTap: (controller.imageModeSelected.value ==
                                      "video")
                                  ? controller.stopAndSaveVideo
                                  :controller.takePicturePressed,
                              child: Stack(
                                //recording button
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Icon(
                                        Icons.circle,
                                        color: controller.isVideoCameraSelected
                                            ? Colors.white
                                            : Colors.red,
                                        size: 70,
                                      )),
                                  SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Center(
                                          child: Icon(
                                        Icons.circle,
                                        color: controller.isVideoCameraSelected
                                            ? Colors.red
                                            : Colors.blueAccent,
                                        size: 50,
                                      ))),
                                  controller.isVideoCameraSelected &&
                                          controller.cameraServices.isRecordingInProgress
                                      ? Icon(
                                          Icons.stop_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ))), //capture button
                      Obx(() => Container(
                            width: MediaQuery.of(context).size.width / 5 - 5,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 4.0,
                                    ),
                                    child: TextButton(
                                      //image select button
                                      onPressed: (controller
                                                  .recordingMode.value ==
                                              "record")
                                          ? () {
                                              print("Recording in Progress");
                                            }
                                          : () {
                                              if (controller.imageModeSelected
                                                      .value ==
                                                  "video") {
                                                controller
                                                    .selectImageVideoRecording(
                                                        0);
                                              } else {
                                                controller
                                                    .selectImageVideoRecording(
                                                        1);
                                              }
                                            },
                                      style: TextButton.styleFrom(
                                        primary: controller
                                                    .imageModeSelected.value ==
                                                "video"
                                            ? Colors.black54
                                            : Colors.black,
                                        backgroundColor: controller
                                                    .imageModeSelected.value ==
                                                "video"
                                            ? Colors.white30
                                            : Colors.white,
                                      ),
                                      child: Text('IMAGE'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  //Video selection button
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, right: 8.0),
                                    child: TextButton(
                                      onPressed: () {
                                        print(
                                            "controller.imageModeSelected.value = ${controller.imageModeSelected.value}");
                                        if (controller
                                                .imageModeSelected.value ==
                                            "image") {
                                          controller
                                              .selectImageVideoRecording(1);
                                        } else {
                                          controller
                                              .selectImageVideoRecording(0);
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        primary: controller
                                                    .imageModeSelected.value ==
                                                "video"
                                            ? Colors.black
                                            : Colors.black54,
                                        backgroundColor: controller
                                                    .imageModeSelected.value ==
                                                "video"
                                            ? Colors.white
                                            : Colors.white30,
                                      ),
                                      child: Text('VIDEO'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )), //image/video selection button
                    ],
                  ),
                ),
              ), //Camera Section
              Row(
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height - 300,
                      child: ActionpadCompactView(
                          key: UniqueKey(),
                          playerList: controller.playerAList,
                          onButtonPushed: controller.onButtonAPushed,
                          orientation: "left",
                          width: MediaQuery.of(context).size.width / 2)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height - 300,
                      child: ActionpadCompactView(
                          key: UniqueKey(),
                          playerList: controller.playerBList,
                          onButtonPushed: controller.onButtonBPushed,
                          orientation: "right",
                          width: MediaQuery.of(context).size.width / 2)),
                ],
              ),
            ],
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: TextButton(
                  onPressed: controller.stopEvent, child: Text("Stop Event"))),
        ])),
      ));
    });
  }
}
