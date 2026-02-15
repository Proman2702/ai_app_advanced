import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AudioStorage {
  final String _fileName;

  AudioStorage({String fileName = 'audio.wav'}) : _fileName = fileName;

  Future<String> getPathWithCreating() async {
    final dir = await getApplicationDocumentsDirectory();
    final recordsDir = Directory(p.join(dir.path, 'records'));
    await recordsDir.create(recursive: true);

    return p.join(recordsDir.path, _fileName);
  }

  Future<String> getPath() async {
    final dir = await getApplicationDocumentsDirectory();
    final recordsDir = Directory(p.join(dir.path, 'records'));
    return p.join(recordsDir.path, _fileName);
  }
}
