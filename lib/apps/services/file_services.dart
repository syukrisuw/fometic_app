import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';


class FileServices extends GetxService {
  static const String baseDirectoryName = "Android";
  static const String fometicDirectoryName = "FometicApp";
  static const String fileSuffix = "Fometic_";
  static const String eventFileSuffix = "Event_";
  static const String videoFileSuffix = "Vid_";
  static const String imageFileSuffix = "Img_";
  static const String fileExtensionCsv = "csv";
  static const String fileExtensionTxt = "txt";
  static const String fileExtensionData = "dat";

  Future<void> init() async {
    try {
      print('[FileServices.init]');
      WidgetsFlutterBinding.ensureInitialized();
    } on Exception catch (e) {
      print('[FileServices.init]>>>Error in file initiation : $e');
    }
  }


  Future<String> getFometicAppLocalPath() async {
    //var dir = await getApplicationDocumentsDirectory();
    Directory? directory;
    directory = await getExternalStorageDirectory();
    String newPath = "";
    print(directory);
    if (directory != null) {
      List<String> paths = directory.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != baseDirectoryName) {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
    }
    newPath = newPath + "/" + fometicDirectoryName;
    directory = Directory(newPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    print(directory.path.toString());
    return directory.path;
  }

  Future<File> getLocalFile(String fileName, String fileExtension) async {
    String path = await getFometicAppLocalPath();
    return File('${path}/${fileSuffix}${eventFileSuffix}${fileName}.${fileExtension}');
  }

  String getDefaultFometicEventVideoFileName(String uniqueId){
    return "${fileSuffix}${videoFileSuffix}${uniqueId}";
  }

  Future<File> getFometicLocalFileByName(String filename) async {
    String path = await getFometicAppLocalPath();
    return File('${path}/${filename}');
  }

  Future<File> writeStringToFile( String fileName, String fileExtension, String data) async {
    //Get full path and filename
    File file = await getLocalFile(fileName, fileExtension);
    return file.writeAsString(data);  //write file as string and return the result
  }

  Future<String> readStringFromFile(String filename, String fileExtension) async {
    String data = "";
    try {
      final file = await getFometicLocalFileByName(filename);
      data = await file.readAsString();
      return data;
    } catch (exception) {
      return data;
    }
  }

}