import 'package:get/get.dart';
import 'package:fometic_app/apps/services/backend_services.dart';

class FavouritesController extends GetxController {
  final String title = 'Favourites Title';
  var counter = 0.obs;
  var dataString =  " ".obs;

  void increaseCounter() {
    counter.value += 1;
  }

  void getData() {
    _getDataFromBackend().then((value) => {
      dataString.value = value
    });
    if (dataString.value != "") {
      print("Data From Backend : " + dataString.value.toString());
    }
  }

  Future<String> _getDataFromBackend() async {
    return await BackendServices.fetchData();
  }

}// TODO Implement this library.