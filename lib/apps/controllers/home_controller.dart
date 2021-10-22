import 'package:get/get.dart';

class HomeController extends GetxController {
  final String title = 'Home Title';
  var counter = 0.obs;

  void increaseCounter() {
    counter.value += 1;
  }
}