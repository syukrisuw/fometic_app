import 'package:get/get.dart';
import 'package:fometic_app/apps/controllers/main_controller.dart';
import 'package:fometic_app/apps/controllers/home_controller.dart';
import 'package:fometic_app/apps/controllers/settings_controller.dart';
import 'package:fometic_app/apps/controllers/favourites_controller.dart';
import 'package:fometic_app/apps/controllers/events_controller.dart';
import 'package:fometic_app/apps/controllers/histories_controller.dart';


class MainBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(HomeController());
    Get.put(FavouritesController());
    //Get.put(EventsController());
    Get.lazyPut<EventsController>(() => EventsController());
    Get.put(HistoriesController());
//    Get.lazyPut<HistoriesController>(() => HistoriesController());
    Get.put(SettingsController());
  }
}