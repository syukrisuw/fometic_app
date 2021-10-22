import 'package:get/get.dart';

class SettingsController extends GetxController {
  final String title = 'Settings Title';
  var counter = 0.obs;

  void increaseCounter() {
    counter.value += 1;
  }
}// TODO Implement this library.