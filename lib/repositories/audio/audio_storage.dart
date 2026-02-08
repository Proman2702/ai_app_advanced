import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AudioStorage {
  final String _fileName;

  AudioStorage({String fileName = 'audio.wav'}) : _fileName = fileName;

  Future<String> getPath() async {
    final dir = await getApplicationDocumentsDirectory();

    final recordsDir = Directory('${dir.path}/records');
    if (!await recordsDir.exists()) {
      await recordsDir.create(recursive: true);
    }

    final path = '${recordsDir.path}/$_fileName';

    final file = File(path);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    return path;
  }
}
