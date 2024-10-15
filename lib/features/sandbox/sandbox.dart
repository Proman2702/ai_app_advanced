// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/repositories/audio/sound_recorder.dart';
import 'package:flutter/material.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  final recorder = SoundRecorder();

  //INIT STATE LOAD ETC

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
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(color: Color(CustomColors.main), borderRadius: BorderRadius.circular(25)),
                    child: Icon(
                      Icons.replay_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration:
                        BoxDecoration(color: Color(CustomColors.delete), borderRadius: BorderRadius.circular(40)),
                    child: Icon(
                      //recorder.isRecording ? Icons.pause : Icons.mic,
                      Icons.mic,
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
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
