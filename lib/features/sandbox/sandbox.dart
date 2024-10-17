// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/repositories/audio/sound_player.dart';
import 'package:ai_app/repositories/audio/sound_recorder.dart';
import 'package:ai_app/repositories/audio/storage.dart';
import 'package:ai_app/repositories/server/upload_to_server.dart';
import 'package:flutter/material.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  final recorder = SoundRecorder();
  final player = SoundPlayer();

  @override
  void initState() {
    super.initState();
    recorder.init();
    player.init();
  }

  @override
  void dispose() {
    player.dispose();
    recorder.dispose();
    super.dispose();
  }

  int? result;
  String ip = 'http://5.tcp.eu.ngrok.io:19987/upload';

  Future<int> get_response(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => SizedBox(
              child: SizedBox(
                height: 20,
                width: 20,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Color(CustomColors.dialogBack),
                )),
              ),
            ));
    try {
      final audioPath = await Storage().completePath();

      final res = await UploadAudio().uploadAudio(audioPath, ip);
      Navigator.pop(context);
      return res;
    } on Exception catch (e) {
      log("Ошибка после запроса $e");
      Navigator.pop(context);
      return 400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Песочница'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Бурда'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await player.togglePlaying(whenFinished: () {});
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(color: Color(CustomColors.main), borderRadius: BorderRadius.circular(25)),
                    child: Icon(
                      player.isPlaying ? Icons.stop : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () async {
                    await recorder.toggleRecording();
                    setState(() {});
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration:
                        BoxDecoration(color: Color(CustomColors.delete), borderRadius: BorderRadius.circular(40)),
                    child: Icon(
                      //recorder.isRecording ? Icons.pause : Icons.mic,
                      recorder.isRecording ? Icons.pause : Icons.mic,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Color(CustomColors.main), borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    "2/3",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  final response = await get_response(context);

                  // Сработал ли запрос
                  // нет
                  if (response == 400) {
                    result = response;
                    setState(() {});
                    // да
                  } else {
                    result = response;
                    log("$result");
                    setState(() {});
                  }
                },
                child: Text("Загрузить")),
            result == null
                ? Text("Пока не воспользовались моделью")
                : result == 400
                    ? Text('Ошибка')
                    : result == 0
                        ? Text('Результат модели: вы здоровы')
                        : result == 1
                            ? Text('Результат модели: у вас картавость')
                            : Text('Результат модели: вы хохлина')
          ],
        ),
      ),
    );
  }
}
