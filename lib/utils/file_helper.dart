import 'package:flutter/material.dart';
import 'package:fometic_app/apps/models/fometic_event_model.dart';
import 'package:fometic_app/apps/models/fometic_model.dart';
import 'package:fometic_app/apps/services/file_services.dart';
import 'package:get/get.dart';

class FileHelperServices extends GetxService {
  FileServices fileServices = Get.find<FileServices>();

  Future<void> init() async {
    try {
      print('[FileHelperServices.init]');
      WidgetsFlutterBinding.ensureInitialized();
    } on Exception catch (e) {
      print('[FileHelperServices.init]>>>Error in file initiation : $e');
    }
  }

  Future<void> writeFometicModelToCsvFile(FometicModel fometicModel) async {
    String data = fometicModel.toString();
    fileServices.writeStringToFile(fometicModel.modelName, "csv", data);
  }

  Future<void> writeFometicEventModelListToCsvFile(List<FometicEventMdl> fometicEventMdlList) async {
    String dataString = FometicEventMdl.getCSVHeaderString()+"\n";
    String modelName = "";
    if (fometicEventMdlList.isNotEmpty) {
      modelName = fometicEventMdlList[0].modelName;
      for (FometicEventMdl eventModel in fometicEventMdlList) {
        dataString += eventModel.toCSVString();
        dataString +="\n";
      }
    } else {
      modelName = FometicEventMdl.modelNameType;
      dataString+="Empty Event Data";
    }

    fileServices.writeStringToFile(modelName, "csv", dataString);
  }
}