import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MainController extends GetxController {
  final String title = 'Main Title';
  var tabIndex = 2;
  var allowWriteFile = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestWritePermission();
  }

  requestWritePermission() async {
    if (await Permission.storage.request().isGranted) {
      print(Permission.storage.status.toString());
      // Either the permission was already granted before or the user just granted it.
    }
    if (await Permission.manageExternalStorage.request().isGranted) {
      print(Permission.manageExternalStorage.status.toString());
      // Either the permission was already granted before or the user just granted it.
    }

// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.manageExternalStorage,
      Permission.storage,
    ].request();
    print(statuses[Permission.manageExternalStorage]);
    print(statuses[Permission.storage]);
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }


}