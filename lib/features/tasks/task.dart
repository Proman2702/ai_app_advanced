// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/features/settings/confirmation_dialog.dart';
import 'package:ai_app/repositories/audio/sound_player.dart';
import 'package:ai_app/repositories/audio/sound_recorder.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:ai_app/repositories/database/tasks/taskbase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late int defectType;
  late int level;
  late int completed;
  final database = DatabaseService();
  User? user;
  List<dynamic>? users;
  GetValues? dbGetter;
  final recorder = SoundRecorder();
  final player = SoundPlayer();
  int recordNum = 1;
  bool recorded = false;
  String? word;

  void startLevel() async {
    log("<taskPage> fewfwfwefwef");
    Tasks tasks = await Tasks.create(defectType, 1);
    word = tasks.getRandomWord();
    setState(() {});
  }

  @override
  void dispose() {
    player.dispose();
    recorder.dispose();
    super.dispose();
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    database.getUsers().listen((snapshot) {
      List<dynamic> users = snapshot.docs;
      dbGetter = GetValues(user: user!, users: users);
      setState(() {});
    });
    super.initState();
    recorder.init();
    player.init();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    var args = ModalRoute.of(context)!.settings.arguments;
    //NULL CHECK VALUE

    if (args == null) {
      return;
    } else {
      args = args as List;
      defectType = args[0];
      level = args[1];
      completed = args[2];

      startLevel();

      setState(() {});
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 65,
            leading: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(CustomColors.main),
                    )),
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 270,
                      height: 60,
                      child: Text(
                        'Уровень $level',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                          child: Icon(
                            Icons.comment,
                            color: Color(CustomColors.main),
                          ),
                        ),
                      ),
                      Text(
                        'Помощь',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: 320,
                height: 260,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, spreadRadius: 1, offset: Offset(0, 2), blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    word == null
                        ? CircularProgressIndicator()
                        : Container(
                            height: 190,
                            width: 300,
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              child: Text(
                                "$word",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 48, fontWeight: FontWeight.bold, color: Color(CustomColors.main)),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        'Произнесите слово вслух, нажав на красную кнопку',
                        style: TextStyle(color: Colors.black26, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      recorded = true;
                      await player.togglePlaying(whenFinished: () {});
                      setState(() {});
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: Color(CustomColors.main),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, spreadRadius: 1, offset: Offset(0, 2), blurRadius: 2)
                          ]),
                      child: Icon(
                        player.isPlaying ? Icons.stop : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      await recorder.toggleRecording();
                      setState(() {});
                    },
                    child: Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Color(CustomColors.delete),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, spreadRadius: 1, offset: Offset(0, 2), blurRadius: 2)
                          ]),
                      child: Icon(
                        //recorder.isRecording ? Icons.pause : Icons.mic,
                        recorder.isRecording ? Icons.pause : Icons.mic,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Color(CustomColors.main), borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "$recordNum/3",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(gradient: ButtonGrad(), borderRadius: BorderRadius.circular(20), boxShadow: [
                  BoxShadow(spreadRadius: 1, offset: Offset(0, 2), blurRadius: 2, color: Colors.black26)
                ]),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Далее",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
