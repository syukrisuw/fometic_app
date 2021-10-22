import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fometic_app/apps/models/event_model.dart';

class EventsController extends GetxController {
  final String title = 'Event Title';
  final String noEventTitle = 'No Event Title';
  var eventViewIndex = 0; //initiated to event_none view
  var counter = 0.obs;
  var event_created = 0.obs;
  var event_name = "New Event".obs;
  var total_player = "0".obs;
  DateTime eventStartTime = DateTime(2021,1,1);

  List<EventModel> eventList = <EventModel>[];

  void increaseCounter() {
    counter.value += 1;
  }

  Future<String> getLocalPath()  async {
    //var dir = await getApplicationDocumentsDirectory();
    Directory?  directory;
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

  Future<File> writeToFile(String eventTitle, List<EventModel> eventModelList) async {
    File file = await getLocalFile(eventTitle);
    String data = "";
    if (eventModelList.isNotEmpty) {
      data = EventModel.getCSVHeaderString() + "\n";
      for (EventModel eventModel in eventModelList) {
        data += eventModel.toCSVString();
        data += "\n";
      }
    } else {
      data = "Empty Event Data";
    }
    return file.writeAsString(data);
  }

  Future<List<EventModel>> readFromFile(String eventTitle) async {
    List<EventModel> eventModelList =  <EventModel>[];
    try {
      final file = await getLocalFile(eventTitle);
      String data = await file.readAsString();
      List<String> dataStringList = data.split("\n");
      dataStringList[0] = "";  //Set Header as empty String
      for( String dataString in dataStringList) {
        if (dataString!="") {
          List<String> dataValueList = dataString.split(",");
          EventModel eventModel = EventModel();
          eventModel.eventTitle = dataValueList[0];
          eventModel.eventName = dataValueList[1];
          eventModel.eventMessage = dataValueList[2];
          eventModel.eventStatus = int.parse(dataValueList[3]);
          eventModel.eventExecutionTime = DateTime.parse(dataValueList[4]);
          eventModelList.add(eventModel);
        }
      }
      return eventModelList;
    } catch (exception) {
      return eventModelList;
    }
  }

   void stopEvent() {
    if (eventList.isNotEmpty) {
      print("HEADER : " + EventModel.getCSVHeaderString());
      EventModel eventModel = EventModel();
      eventModel.eventTitle = event_name.value;
      eventModel.eventName = "Stop Event";
      eventModel.eventMessage = "Event Stop Completed";
      eventModel.eventStatus = 999;
      eventModel.eventExecutionTime = DateTime.now();
      eventList.add(eventModel);
      for (EventModel eventModel in eventList) {
        print("Event : " + eventModel.toCSVString());
      }
      //Write to CSV File
      print("Event Length : " + eventList.length.toString());
      writeToFile(event_name.value, eventList);
    }
    total_player.value = "0";
    event_created.value = 0;
    eventViewIndex = 0;
    update();
  }

  void clearEventList(){
    event_name.value = "";
    eventList.clear();
  }

  void cancelEvent() {
    event_name.value = "";
    total_player.value = "0";
    event_created.value = 0;
    eventViewIndex = 0;
    update();
  }

  void newEvent() {
    event_created.value = 1;
    eventViewIndex = 1;
    update();
  }

  void startNewEvent( String eventName, String totalPlayer ) {
    clearEventList();
    event_name.value = eventName;
    total_player.value = totalPlayer;
    event_created.value = 1;
    eventViewIndex = 2;
    eventStartTime = DateTime.now();
    EventModel eventModel = EventModel();
    eventModel.eventTitle = event_name.value;
    eventModel.eventName = "Start New Event";
    eventModel.eventMessage = "Event Started";
    eventModel.eventExecutionTime = eventStartTime;
    eventList.add(eventModel);

    update();
  }

  void updateEventName( String eventName ) {
    event_name.value = eventName;
    event_created.value = 1;
    eventViewIndex = 2;
    update();
  }

  void setupPlayer() {
  }


  double degrees = 0.0;
  double distance = 0.0;
  String pad = "";

  double validateDegrees (double degrees) {
    //Clock like degrees, 0 on top
    double valid_degrees = 0.0;
    if ( degrees >= 0.0 && degrees < 20.0 ) {
      valid_degrees = 0.0;
    } else if ( degrees >= 20.0 && degrees < 60.0 ){
      valid_degrees = 45.0;
    } else if ( degrees >= 60.0 && degrees < 120.0 ) {
      valid_degrees = 90.0;
    } else if ( degrees >= 120.0 && degrees < 150.0 ){
      valid_degrees = 135.0;
    } else if ( degrees >= 150.0 && degrees < 210.0 ){
      valid_degrees = 180.0;
    } else if ( degrees >= 210.0 && degrees < 230.0 ){
      valid_degrees = 225.0;
    } else if ( degrees >= 230.0 && degrees < 290.0 ){
      valid_degrees = 270.0;
    } else if ( degrees >= 290.0 && degrees < 330.0 ){
      valid_degrees = 315.0;
    } else if ( degrees >= 330.0 && degrees < 360.0 ){
      valid_degrees = 0.0;
    }
    return valid_degrees;
  }

  String padActionMapper(double degrees) {
    var actionString = "";
    switch(degrees.toInt()) {
      case 0: {
        actionString = "Success Goal";
      }
      break;
      case 180: {
        actionString = "Prevent Goal";
      }
      break;

      case 45: {
        actionString = "Shoot On Target";
      }
      break;
      case 315: {
        actionString = "Shoot Off Target";
      }
      break;

      case 90: {
        actionString = "Success Pass";
      }
      break;
      case 270: {
        actionString = "Failed Pass";
      }
      break;

      case 135: {
        actionString = "Success Tackle";
      }
      break;
      case 225: {
        actionString = "Failed Tackle";
      }
      break;

      default: {
        actionString = "Unknown";
      }
      break;
    }
    return actionString;
  }


  void padACallback(double degrees, double distanceFromCenter) {
    degrees = validateDegrees(degrees);

    distance = distanceFromCenter;
    pad = "A";
    EventModel eventModel = EventModel();
    eventModel.eventTitle = event_name.value;
    eventModel.eventName = "Player A";
    eventModel.eventMessage = padActionMapper(degrees);
    eventModel.eventExecutionTime = DateTime.now();
    eventList.add(eventModel);
    print("pad:"+pad +" degrees: "+ degrees.toString()+" distance:"+distance.toString());
  }
  void padBCallback(double degrees, double distanceFromCenter) {
    degrees = validateDegrees(degrees);
    distance = distanceFromCenter;
    pad = "B";
    EventModel eventModel = EventModel();
    eventModel.eventTitle = event_name.value;
    eventModel.eventName = "Player B";
    eventModel.eventMessage = padActionMapper(degrees);
    eventModel.eventExecutionTime = DateTime.now();
    eventList.add(eventModel);
    print("pad:"+pad +" degrees: "+ degrees.toString()+" distance:"+distance.toString());
  }
  void padCCallback(double degrees, double distanceFromCenter) {
    degrees = validateDegrees(degrees);
    distance = distanceFromCenter;
    pad = "C";
    EventModel eventModel = EventModel();
    eventModel.eventTitle = event_name.value;
    eventModel.eventName = "Player C";
    eventModel.eventMessage = padActionMapper(degrees);
    eventModel.eventExecutionTime = DateTime.now();
    eventList.add(eventModel);
    print("pad:"+pad +" degrees: "+ degrees.toString()+" distance:"+distance.toString());
  }

  void padDCallback(double degrees, double distanceFromCenter) {
    degrees = validateDegrees(degrees);
    distance = distanceFromCenter;
    pad = "D";
    EventModel eventModel = EventModel();
    eventModel.eventTitle = event_name.value;
    eventModel.eventName = "Player D";
    eventModel.eventMessage = padActionMapper(degrees);
    eventModel.eventExecutionTime = DateTime.now();
    eventList.add(eventModel);
    print("pad:"+pad +" degrees: "+ degrees.toString()+" distance:"+distance.toString());
  }
}