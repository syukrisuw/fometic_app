import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fometic_app/apps/models/fometic_event_model.dart';
import 'package:fometic_app/apps/services/camera_services.dart';
import 'package:fometic_app/apps/services/file_services.dart';
import 'package:fometic_app/utils/file_helper.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fometic_app/apps/models/player_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:camera/camera.dart';

import 'main_controller.dart';


class EventsController extends GetxController with WidgetsBindingObserver {

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
  FileHelperServices FileHelper = Get.find<FileHelperServices>();

  var imageModeSelected = "image".obs;
  var recordingMode = "stop".obs;
  bool isVideoCameraSelected = false;
  bool isMounted = false;

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

  @override
  void onInit() {
    print("[EventController.onInit]");
    locationLat.value = "-6.17553";
    locationLong.value = "106.82747";
    mapWidth.value = Get.mediaQuery.size.width.toInt();
    //SystemChrome.setEnabledSystemUIOverlays([]);
    initCamera().then((value) => onNewCameraSelected(cameraServices.cameras[0], true));

    super.onInit();
  }

  @override
  void onClose() {
    print("[EventController.onClose]");
    super.onClose();
  }


  void selectImageVideoRecording(int mode){
    print("[EventController.selectImageVideoRecording]");
    if (mode==1) {
      imageModeSelected.value="video";
      recordingMode.value="stop";
      isVideoCameraSelected = true;
      print("Selecting Video Record Mode");
    } else {
      imageModeSelected.value="image";
      recordingMode.value="stop";
      isVideoCameraSelected = false;
      print("Selecting Image Capture Mode");
    }
    update();
  }

  Future<void> startVideoRecording() async {
    print("[EventController.startVideoRecording]");
    final CameraController? cameraController = cameraServices.camController;
    if (cameraServices.camController!.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      return;
    }
    try {
      await cameraController!.startVideoRecording();
      cameraServices.isRecordingInProgress = true;
        recordingMode.value="record";
        print(cameraServices.isRecordingInProgress);
    } on CameraException catch (e) {
      print('Error starting to record video: $e');
    } finally {
      update();
    }

  }

  Future<XFile?> stopVideoRecording() async {
    print("[EventController.stopVideoRecording]Stop Video recording");
    if (!cameraServices.camController!.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }
    try {
      XFile file = await cameraServices.camController!.stopVideoRecording();
        recordingMode.value="stop";
        cameraServices.isRecordingInProgress = false;
        print("[EventController.stopVideoRecording] isRecordingInProgress=${cameraServices.isRecordingInProgress}");
        update();
      return file;
    } on CameraException catch (e) {
      print('[EventController]Error stopping video recording: $e');
      update();
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    if (!cameraServices.camController!.value.isRecordingVideo) {
      // Video recording is not in progress
      return;
    }
    try {
      await cameraServices.camController!.pauseVideoRecording();
    } on CameraException catch (e) {
      print('Error pausing video recording: $e');
    } finally {
      update();
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!cameraServices.camController!.value.isRecordingVideo) {
      // No video recording was in progress
      update();
      return;
    }
    try {
      await cameraServices.camController!.resumeVideoRecording();
    } on CameraException catch (e) {
      print('Error resuming video recording: $e');
    } finally {
      update();
    }
  }

  void onLocationButtonPressed() {
    mapWidth.value= Get.mediaQuery.size.width.toInt()-5;
    Future<Position> currentPos = determinePosition();
    currentPos.then((Position pos) {
      locationLat.value = pos.latitude.toString();
      locationLong.value= pos.longitude.toString();
    }, onError: (e) {
      locationLat.value = "-6.17553";
      locationLong.value = "106.82747";
    });
    update();
  }

  void increaseCounter() {
    counter.value += 1;
  }

  Future<String> getLocalPath() async {
    //var dir = await getApplicationDocumentsDirectory();
    Directory? directory;
    directory = await getExternalStorageDirectory();
    String newPath = "";
    print(directory);
    if (directory != null) {
      List<String> paths = directory.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
    }
    newPath = newPath + "/FometicApp";
    directory = Directory(newPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    print(directory.path.toString());
    return directory.path;
  }

  Future<File> getLocalFile(String eventTitle) async {
    String path = await getLocalPath();
    return File('$path/Event_$eventTitle.csv');
  }

  Future<File> writeToFile(
      String eventTitle, List<FometicEventMdl> eventModelList) async {
    File file = await getLocalFile(eventTitle);
    String data = "";
    if (eventModelList.isNotEmpty) {
      data = FometicEventMdl.getCSVHeaderString() + "\n";
      for (FometicEventMdl eventModel in eventModelList) {
        data += eventModel.toCSVString();
        data += "\n";
      }
    } else {
      data = "Empty Event Data";
    }
    return file.writeAsString(data);
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

  Future<List<FometicEventMdl>> readFromFile(String eventTitle) async {
    List<FometicEventMdl> eventModelList = <FometicEventMdl>[];
    try {
      final file = await getLocalFile(eventTitle);
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

  void saveEventStat() {
    if (eventList.isNotEmpty) {
      print("HEADER : " + FometicEventMdl.getCSVHeaderString());
      FometicEventMdl eventModel = FometicEventMdl(
          eventTitle: event_name.value,
          eventName: "Stop Event",
          eventMessage: "Event Stop Completed",
          eventStatus: 999,
          eventExecutionTime: DateTime.now()
      );

      eventList.add(eventModel);
      for (FometicEventMdl eventModel in eventList) {
        print("Event : " + eventModel.toCSVString());
      }
      //Write to CSV File
      print("Event Length : " + eventList.length.toString());
      writeToFile(event_name.value, eventList);
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

  void stopEvent() {

    if(cameraServices.isRecordingInProgress){
      print("isRecordingInProgress");
      stopVideoRecording().then((value) => {
        print("Saving Event"),
        saveEventStat(),
        cameraServices.isRecordingInProgress = false
      });
    }else {
      saveEventStat();
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
        eventStatus: 100,
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

  void onAddPlayerConfirm(String number, String playerName, String playerPosition, bool isSubstitution) {
    if (totalPlayer.value == 0) {
      playerModelList.clear();
    }
    PlayerModel addPlayerModel = PlayerModel(playerNumber: int.parse(number), playerName: playerName, playerPosition: playerPosition);
    if(isSubstitution){
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
        child:Column(
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
      ),),
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

  Future<void> initCamera() async {
    print("[EventController.initCamera]");
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameraServices.cameras = await availableCameras();
    } on CameraException catch (e) {
      print('Error in fetching the cameras: $e');
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription, bool mounted) async {
    final previousCameraController = cameraServices.camController;

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
      cameraServices.camController = cameraController;
      update();
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) update();
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the boolean
    if (mounted) {
      cameraServices.isCameraInitialized = cameraServices.camController!.value.isInitialized;
      update();
    }
  }

  LatLng getCurrentLatLang() {
    double lat = -6.17553;
    double long = 106.82747;
    try {
      lat = double.parse(locationLat.value);
      long = double.parse(locationLong.value);
    } catch (e){
      print("PARSING FAILED, using default location");
      double lat = -6.17553;
      double long = 106.82747;
    }
    return LatLng(lat, long);
  }
}
