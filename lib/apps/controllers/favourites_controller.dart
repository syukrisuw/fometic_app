import 'package:get/get.dart';

class FavouritesController extends GetxController {
  final String title = 'Favourites Title';
  var counter = 0.obs;

  void increaseCounter() {
    counter.value += 1;
  }
}// TODO Implement this library.