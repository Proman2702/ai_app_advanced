import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class Storage {
  String completePath = "";
  String directoryPath = "";

  Future<String> _completePath(String directory) async {
    var fileName = _fileName();
    return "$directory$fileName";
  }

  Future<String> _directoryPath() async {
    var directory = await getApplicationDocumentsDirectory();
    var directoryPath = directory.path;
    return "$directoryPath/records/";
  }

  String _fileName() {
    return "record.wav";
  }

  Future _createFile() async {
    File(completePath).create(recursive: true).then((File file) async {
      //write to file
      Uint8List bytes = await file.readAsBytes();
      file.writeAsBytes(bytes);
      print("FILE CREATED AT : " + file.path);
    });
  }

  void _createDirectory() async {
    bool isDirectoryCreated = await Directory(directoryPath).exists();
    if (!isDirectoryCreated) {
      Directory(directoryPath).create().then((Directory directory) {
        print("DIRECTORY CREATED AT : " + directory.path);
      });
    }
  }
}
