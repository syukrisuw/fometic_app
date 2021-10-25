import 'package:path_provider/path_provider.dart';
import 'dart:io';


class FileHelper {
  Future<String> getLocalPath()  async {
    //var dir = await getApplicationDocumentsDirectory();
    Directory?  directory;
    directory = await getExternalStorageDirectory();
    String newPath = "";
    print(directory);
    if (directory != null) {
      List<String> paths = directory.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
    }
    newPath = newPath + "/FometicApp";
    directory = Directory(newPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    print(directory.path.toString());
    return directory.path;
  }

  Future<File> getLocalFile(String prefix, String suffix, String fileExtension) async {
    String path = await getLocalPath();
    return File('${path}/${prefix}_Event_${suffix}.${fileExtension}');
  }

  Future<File> getLocalFileByName(String filename) async {
    String path = await getLocalPath();
    return File('${path}/${filename}');
  }

  Future<File> writeToFile(String prefix, String suffix, String data) async {
    File file = await getLocalFile("Fometic", "Data", "csv");
    String data = "";
    if (data.isEmpty) {
      data = "Empty Event Data";
    }
    return file.writeAsString(data);
  }

  Future<String> readFromFile(String filename) async {
    String data = "";
    try {
      final file = await getLocalFileByName(filename);
      data = await file.readAsString();
      return data;
    } catch (exception) {
      return data;
    }
  }
}