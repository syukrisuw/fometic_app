import 'package:get/get.dart';

class HistoriesController extends GetxController {
  final String title = 'Histories Title';
  var counter = 0.obs;

  void increaseCounter() {
    counter.value += 1;
  }
}