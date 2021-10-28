import 'package:get/get.dart';

class HomeController extends GetxController {
  final String title = 'Home Title';
  var counter = 0.obs;

  var statTimeA = "".obs;
  var statTimeB = "".obs;
  var playerAName = "".obs;
  var lastActionA = "".obs;
  var playerBName = "".obs;
  var lastActionB = "".obs;
  void increaseCounter() {
    counter.value += 1;
  }

  void onButtonAPushed(String playerName, String actionPushed) {
    DateTime actionTime = DateTime.now();
    statTimeA.value = actionTime.hour.toString() + ":" + actionTime.minute.toString() + ":" +actionTime.second.toString() + ":" +actionTime.millisecond.toString();
    playerAName.value = playerName;
    lastActionA.value = actionPushed;
  }

  void onButtonBPushed( String playerName, String actionPushed) {
    DateTime actionTime = DateTime.now();
    statTimeB.value = actionTime.hour.toString() + ":" + actionTime.minute.toString() + ":" +actionTime.second.toString() + ":" +actionTime.millisecond.toString();
    playerBName.value = playerName;
    lastActionB.value = actionPushed;
  }
}