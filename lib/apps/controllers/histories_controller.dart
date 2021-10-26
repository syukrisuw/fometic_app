import 'package:get/get.dart';

class HistoriesController extends GetxController {
  final String title = 'Histories Title';
  var playerAName = "".obs;
  var lastActionA = "".obs;
  var playerBName = "".obs;
  var lastActionB = "".obs;

  var counter = 0.obs;

  void increaseCounter() {
    counter.value += 1;
  }



  void onButtonAPushed(String playerName, String actionPushed) {
    playerAName.value = playerName;
    lastActionA.value = actionPushed;
  }

  void onButtonBPushed( String playerName, String actionPushed) {
    playerBName.value = playerName;
    lastActionB.value = actionPushed;
  }
}