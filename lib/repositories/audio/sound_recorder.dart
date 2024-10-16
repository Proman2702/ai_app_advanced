import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

final audioPath = 'audio.aac';

class SoundRecorder {
  FlutterSoundRecorder? audioRecorder;
  bool isRecorderInit = false;

  bool get isRecording => audioRecorder!.isRecording;

  Future init() async {
    audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Разрешение отклонено');
    }
    await audioRecorder!.openAudioSession();
    isRecorderInit = true;
  }

  void dispose() {
    if (!isRecorderInit) {
      return;
    }

    audioRecorder!.closeAudioSession();
    audioRecorder = null;
    isRecorderInit = false;
  }

  Future<void> record() async {
    if (!isRecorderInit) {
      return;
    }

    await audioRecorder!.startRecorder(toFile: audioPath);
  }

  Future<void> stop() async {
    if (!isRecorderInit) {
      return;
    }

    await audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if (audioRecorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }
}
