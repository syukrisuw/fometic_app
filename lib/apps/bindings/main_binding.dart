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
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FavouritesController>(() => FavouritesController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<EventsController>(() => EventsController());
    Get.lazyPut<HistoriesController>(() => HistoriesController());
  }
}