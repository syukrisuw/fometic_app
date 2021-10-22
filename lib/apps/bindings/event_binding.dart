import 'package:get/get.dart';
import 'package:fometic_app/apps/controllers/main_controller.dart';

class EventBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}