// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/features/drawer.dart';
import 'package:ai_app/repositories/audio/sound_player.dart';
import 'package:ai_app/repositories/audio/sound_recorder.dart';
import 'package:ai_app/repositories/audio/storage.dart';
import 'package:ai_app/repositories/server/ip.dart';
import 'package:ai_app/repositories/server/upload_to_server.dart';
import 'package:flutter/material.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
  String ip = Ip().getIp;

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
    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(chosen: 5),
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(preferredSize: Size.fromHeight(65), child: AppBar(
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
                backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: Colors.black,
            leadingWidth: 60,
            leading: Padding(
              padding: const EdgeInsets.only(top: 5, left: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back, color: Color(CustomColors.main), size: 30))
            ),
            title: Center(
                child: Text(
              "Песочница",
              style: TextStyle(color: Color(CustomColors.main), fontWeight: FontWeight.w700, fontSize: 25),
            )),
            actions: [SizedBox(width: 50)],
          ),
        ),
        body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Container(
              width: 330,
              height: 200,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
              child: Column(
                children: [
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
                                  : Text('Результат модели: вы хохлина'),
                ],
              ),
            )
          ],
        ),
      ),
      )
    );
  }
}
