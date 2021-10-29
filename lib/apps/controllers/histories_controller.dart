import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fometic_app/apps/services/camera_services.dart';
import 'package:fometic_app/apps/services/file_services.dart';
import 'package:fometic_app/utils/file_helper.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:fometic_app/apps/models/fometic_event_model.dart';
import 'package:fometic_app/apps/models/player_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:camera/camera.dart';
import 'main_controller.dart';
import 'package:intl/intl.dart';

class HistoriesController extends GetxController {
  final String title = 'Event Title';
  final String noEventTitle = 'No Event Title';
  var locationLat = "-6.17553".obs;
  var locationLong = "106.82747".obs;
  var eventViewIndex = 0; //initiated to event_none view
  var counter = 0.obs;
  var event_created = 0.obs;
  var event_name = "New Event".obs;
  var total_player = "0".obs;
  var totalPlayer = 0.obs;
  var mapWidth = Get.mediaQuery.size.width.toInt().obs;

  CameraServices cameraServices = Get.find<CameraServices>();
  FileServices fileServices = Get.find<FileServices>();
  FileHelper fileHelper = Get.find<FileHelper>();

  var imageModeSelected = "image".obs;
  var recordingMode = "stop".obs;

  bool isVideoCameraSelected = false;

  GlobalKey actionpadCompactLeft = new GlobalKey();
  GlobalKey actionpadCompactRight = new GlobalKey();

  DateTime eventStartTime = DateTime(2021, 1, 1);

  List<PlayerModel> playerModelList = <PlayerModel>[].obs;

  List<String> playerList = <String>[].obs;
  List<FometicEventMdl> eventList = <FometicEventMdl>[];

  TextEditingController eventNameTextController = TextEditingController();
  TextEditingController eventTotalPlayerTextController =
      TextEditingController();
  TextEditingController playerNumberTextController = TextEditingController();
  TextEditingController playerNameTextController = TextEditingController();
  TextEditingController playerPositionTextController = TextEditingController();
  TextEditingController playerStatusTextController = TextEditingController();

  List<String> playerAList = <String>[];
  List<String> playerBList = <String>[];

  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    print("[HistoriesController.onInit]");
    locationLat.value = "-6.17553";
    locationLong.value = "106.82747";
    mapWidth.value = Get.mediaQuery.size.width.toInt();
    //SystemChrome.setEnabledSystemUIOverlays([]);

    super.onInit();
  }

  @override
  void onClose() {
    print("[HistoriesController.onInit]");

    super.onClose();
  }

  Future<void> stopAndSaveVideo() async {
    if (cameraServices.isRecordingInProgress) {
      print("Trying to stopVideoRecording");
      XFile? rawVideo = await cameraServices.stopVideoRecording();
      File videoFile = File(rawVideo!.path);

      DateTime currentDateTime = DateTime.now();
      DateFormat dateFormat = DateFormat("yyyyMMdd_HHmmss_SSS");
      String currentUnixString = dateFormat.format(currentDateTime);

      final directory = await fileServices.getFometicAppLocalPath();
      String fileFormat = videoFile.path.split('.').last;

      print("Trying to save videoFile");
      String fometicVideoFileName =
          fileServices.getDefaultFometicEventVideoFileName(currentUnixString);
      videoFile = await videoFile.copy(
        '${directory}/$fometicVideoFileName.$fileFormat',
      );

      //controller.startVideoPlayer();
    } else {
      print("Trying to startVideoRecording");
      await cameraServices.startVideoRecording();
    }
  }

  void selectImageVideoRecording(int mode) {
    if (mode == 1) {
      imageModeSelected.value = "video";
      recordingMode.value = "stop";
      isVideoCameraSelected = true;
      print("Selecting Video Record Mode");
    } else {
      imageModeSelected.value = "image";
      recordingMode.value = "stop";
      isVideoCameraSelected = false;
      print("Selecting Image Capture Mode");
    }
    update();
  }

  void onLocationButtonPressed() {
    mapWidth.value = Get.mediaQuery.size.width.toInt() - 5;
    Future<Position> currentPos = determinePosition();
    currentPos.then((Position pos) {
      locationLat.value = pos.latitude.toString();
      locationLong.value = pos.longitude.toString();
    }, onError: (e) {
      locationLat.value = "-6.17553";
      locationLong.value = "106.82747";
    });
    update();
  }

  void increaseCounter() {
    counter.value += 1;
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = cameraServices.camController;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  Future<List<FometicEventMdl>> readFometicEventFromCsvFile(String eventTitle) async {
    List<FometicEventMdl> eventModelList = <FometicEventMdl>[];
    try {
      final file = await fileServices.getFometicLocalFileByName(eventTitle);
      String data = await file.readAsString();
      List<String> dataStringList = data.split("\n");
      dataStringList[0] = ""; //Set Header as empty String
      for (String dataString in dataStringList) {
        if (dataString != "") {
          List<String> dataValueList = dataString.split(",");
          FometicEventMdl eventModel = FometicEventMdl(
              eventTitle: dataValueList[0],
              eventName: dataValueList[1],
              eventMessage: dataValueList[2],
              eventStatus: int.parse(dataValueList[3]),
              eventExecutionTime: DateTime.parse(dataValueList[4])
          );
          eventModelList.add(eventModel);
        }
      }
      return eventModelList;
    } catch (exception) {
      return eventModelList;
    }
  }

  Future<void> saveEventStat() async {
    if (eventList.isNotEmpty) {
      await fileHelper.writeFometicEventModelListToCsvFile(eventList);
    }
    eventNameTextController.text = "";
    eventTotalPlayerTextController.text = "";
    playerAList.clear();
    playerBList.clear();
    totalPlayer.value = 0;
    playerModelList.clear();
    total_player.value = "0";
    event_created.value = 0;
    eventViewIndex = 0;
    update();
  }

  void stopEvent() async {
    if (cameraServices.isRecordingInProgress) {
      await cameraServices.stopVideoRecording();
      await saveEventStat();
      cameraServices.isRecordingInProgress = false;
    } else {
      await saveEventStat();
    }
  }

  void clearEventList() {
    event_name.value = "";
    eventList.clear();
  }

  void cancelEvent() {
    clearEventList();
    total_player.value = "0";
    event_created.value = 0;
    eventViewIndex = 0;
    update();
  }

  void newEvent() {
    clearEventList();
    event_created.value = 1;
    eventViewIndex = 1;
    playerModelList.clear();
    playerAList.clear();
    playerBList.clear();
    totalPlayer.value = 0;
    update();
  }

  void startNewEvent(String eventName, String totalPlayer) {
    clearEventList();
    event_name.value = eventName;
    total_player.value = totalPlayer;
    event_created.value = 1;
    eventViewIndex = 2;
    eventStartTime = DateTime.now();

   FometicEventMdl eventModel = FometicEventMdl(
        eventTitle: event_name.value,
        eventName: "Start New Event",
        eventMessage: "Event Started",
        eventStatus: 1,
        eventExecutionTime: eventStartTime
    );
   eventList.add(eventModel);

    update();
  }

  void updateEventName(String eventName) {
    event_name.value = eventName;
    event_created.value = 1;
    eventViewIndex = 2;
    update();
  }

  void setupPlayer() {}

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void onAddPlayerCancel() {
    Get.back();
  }

  void onAddPlayerEventConfirm() {
    if (totalPlayer.value == 0) {
      playerList.clear();
    }
    playerList.add("New Player");
    totalPlayer.value += 1;
    Get.back();
  }

  void onAddPlayerConfirm(String number, String playerName,
      String playerPosition, bool isSubstitution) {
    if (totalPlayer.value == 0) {
      playerModelList.clear();
    }
    PlayerModel addPlayerModel = PlayerModel(
        playerNumber: int.parse(number),
        playerName: playerName,
        playerPosition: playerPosition);
    if (isSubstitution) {
      addPlayerModel.playerStatus = "Substitution";
    } else {
      addPlayerModel.playerStatus = "Playing";
    }
    playerModelList.add(addPlayerModel);
    totalPlayer.value += 1;
    Get.back();
  }

  void onAddPlayerButtonPressed() {
    //Get.dialog(AddPlayerDialog( onCancelCallback: onAddPlayerCancel, onConfirmCallback: onAddPlayerConfirm));
    Get.defaultDialog(
      title: "Add Player",
      content: SizedBox(
        width: 400,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(children: <Widget>[
              TextField(
                controller: this.playerNameTextController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name of the Player",
                    labelText: "Player Name",
                    labelStyle: TextStyle(fontSize: 24, color: Colors.black)),
              ),
            ]),
          ],
        ),
      ),
      onConfirm: onAddPlayerEventConfirm,
      onCancel: onAddPlayerCancel,
    );
  }

  void onRemovePlayer(int index) {
    if (totalPlayer.value > 0) {
      playerModelList.removeAt(index);
      totalPlayer.value -= 1;
    } else {
      playerModelList.clear();
    }
  }

  void onButtonAPushed(String playerName, String actionPushed) {
    FometicEventMdl eventModel = FometicEventMdl(
        eventTitle: event_name.value,
        eventName: playerName,
        eventMessage: actionPushed,
        eventStatus: 1,
        eventExecutionTime: DateTime.now()
    );
    eventList.add(eventModel);
  }

  void onButtonBPushed(String playerName, String actionPushed) {
    FometicEventMdl eventModel = FometicEventMdl(
        eventTitle: event_name.value,
        eventName: playerName,
        eventMessage: actionPushed,
        eventStatus: 1,
        eventExecutionTime: DateTime.now()
    );
    eventList.add(eventModel);
  }

  LatLng getCurrentLatLang() {
    double lat = -6.17553;
    double long = 106.82747;
    try {
      lat = double.parse(locationLat.value);
      long = double.parse(locationLong.value);
    } catch (e) {
      print("PARSING FAILED, using default location");
      double lat = -6.17553;
      double long = 106.82747;
    }
    return LatLng(lat, long);
  }

  Future<void> takePicturePressed() async {

      print("Trying to takePicture");
      // code to handle image clicking
      XFile? rawImage =
      await takePicture();
      File imageFile = File(rawImage!.path);

      int currentUnix =
          DateTime.now().millisecondsSinceEpoch;
      final directoryPath =
      await fileServices.getFometicAppLocalPath();
      String fileFormat =
          imageFile.path.split('.').last;
      print("Trying to save imageFile");
      await imageFile.copy(
        '${directoryPath}/$currentUnix.$fileFormat',
      );
  }
}
