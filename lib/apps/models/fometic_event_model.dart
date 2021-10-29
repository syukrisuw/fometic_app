import 'package:fometic_app/apps/models/fometic_model.dart';

class FometicEventMdl extends FometicModel{
  static const modelNameType = "FometicEventModel";
  String eventTitle = "";
  String eventName = "";
  String eventMessage = "";
  DateTime eventExecutionTime = DateTime.now();
  int eventStatus = 0;

  FometicEventMdl({
    required this.eventTitle,
    required this.eventName,
    required this.eventMessage,
    required this.eventStatus,
    required this.eventExecutionTime
  }) : super(modelName: modelNameType);

  @override
  String toString(){

   return "$runtimeType;$modelName;$eventTitle;$eventName;$eventMessage;$eventStatus;$eventExecutionTime";
  }

  static String getCSVHeaderString() {
    return "eventTitle,eventName,eventMessage,eventStatus,eventExecutionTime";
  }

  String toCSVString() {
    return "$eventTitle,$eventName,$eventMessage,$eventStatus,${eventExecutionTime.toIso8601String()}" ;
  }

}