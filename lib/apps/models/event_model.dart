class EventModel {
  String eventTitle = "";
  String eventName = "";
  String eventMessage = "";
  DateTime eventExecutionTime = DateTime.now();
  int eventStatus = 0;

  static String getCSVHeaderString() {
    return "eventTitle,eventName,eventMessage,eventStatus,eventExecutionTime";
  }

  String toCSVString() {
    return this.eventTitle + "," + this.eventName + ","+ this.eventMessage + "," + this.eventStatus.toString() + "," + this.eventExecutionTime.toIso8601String() ;
  }
}