// ignore_for_file: unused_import

import 'dart:async';

import 'package:ai_app/features/tasks/help.dart';
import 'package:ai_app/models/user.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:ai_app/repositories/database/tasks/taskbase.dart';
import 'package:ai_app/repositories/server/ip.dart';
import 'package:ai_app/repositories/server/upload_to_server.dart';
import 'package:ai_app/repositories/audio/sound_recorder.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/repositories/audio/sound_player.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/repositories/audio/storage.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:ai_app/features/tasks/ai_hander.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ai_app/etc/colors/colors.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

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
  late int recordNum = 0;
  late bool recorded = false;

  late List<int> results = [];
  String? word;

  // функция обработки результата страницы
  void startLevel() async {
    // если 3 попытки истрачено
    if (recordNum >= 3) {
      // если дефектов нет или только 1
      if (results.where((e) => e == 0).length >= 2) {
        showModalBottomSheet(context: context, builder: (context) => AIInfoSheet(type: 'right'));

        // если уровень еще не пройден
        if (completed == 0) {
          CustomUser curUser = dbGetter!.getUser()!;
          var curCombo = curUser.current_combo; // аолучение данных с БД
          var curLevels = curUser.lessons_passed;
          var curCorrectLevels = curUser.lessons_correct;

          curCombo['$defectType'] += 1; // к текущему комбо +1
          curLevels['$defectType'] += 1;
          curCorrectLevels['$defectType'] += 1;

          // записываем результат обратно в БД
          await database.updateUser(
              curUser.copyWith(current_combo: curCombo, lessons_correct: curCorrectLevels, lessons_passed: curLevels));

          // если комбо больше или 5
          if (curCombo['$defectType'] >= 5) {
            curCombo['$defectType'] = 0; //обнуляем его

            var curLevel = curUser.current_level; // получаем текущий уровень из БД

            if (curLevel['$defectType'] == 0) {
              curLevel['$defectType'] += 1;
            }
            curLevel['$defectType'] += 1; // переходим на следующий

            // записываем данные обратно в БД
            await database.updateUser(curUser.copyWith(current_combo: curCombo, current_level: curLevel));
            Navigator.of(context).pop(); // выходим из окна уведомелния результата
            Navigator.of(context).pop(); // выходим из страницы

            // уведомляем, что пользователь прошел уровень
            showModalBottomSheet(context: context, builder: (context) => AIInfoSheet(type: 'passed'));
            return;
          }
        }
        // если 2 или больше дефектов
      } else {
        showModalBottomSheet(context: context, builder: (context) => AIInfoSheet(type: 'wrong'));

        // если уровень еще не пройден
        if (completed == 0) {
          CustomUser curUser = dbGetter!.getUser()!;

          var curCombo = curUser.current_combo; // получаем комбо из БД
          var curLevels = curUser.lessons_passed;

          curCombo['$defectType'] = 0; // обнуляем комбо и записываем в БД
          curLevels['$defectType'] += 1;
          await database.updateUser(curUser.copyWith(current_combo: curCombo, lessons_passed: curLevels));
        }
      }
    }

    // если пользователь не вышел со страницы
    // сбрасываем список с дефектами и попытки
    recordNum = 1;
    results = [];

    // даем новое задание

    Tasks tasks = await Tasks.create(defectType, level);
    word = tasks.getRandomWord();
    log("<taskPage> Уровень загружен");

    if (mounted)
      setState(() {});
    else
      return;
  }

  @override
  void dispose() {
    player.dispose();
    recorder.dispose();
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    recordNum = 0;
    results = [];
    user = FirebaseAuth.instance.currentUser;
    database.getUsers().listen((snapshot) {
      List<dynamic> users = snapshot.docs;
      dbGetter = GetValues(user: user!, users: users);
      setState(() {});
    });

    recorder.init();
    player.init();
  }

  Timer? _timer;
  int _start = 7;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 1) {
          setState(() {
            endTimer(true);
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void endTimer(bool stop) async {
    if (_timer != null) _timer!.cancel();
    log("<taskPage> timer ended");
    _start = 7;
    if (stop) {
      await recorder.toggleRecording();
      setState(() {});
    }
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

      if (recordNum == 0) {
        startLevel();
      }
    }

    super.didChangeDependencies();
  }

  int? result; // поле, куда будет помещен результат

  String ip = Ip().getIp; // айпишник сервера (http://{ip}/upload)

  // Функция формирования запроса со страницы
  Future<int> get_response(BuildContext context) async {
    showDialog(
        // circularprogress indicator
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
      final audioPath = await Storage().completePath(); // Получение пути локального файла записи диктофона
      final res = await UploadAudio().uploadAudio(audioPath, ip); // Загрузка файла на сервер
      Navigator.pop(context); // Выход из circularprogressindicator
      return res; // возврат результата запроса
    } on Exception catch (e) {
      log("<taskPage> Ошибка после запроса $e"); // ошибка формирования запроса
      Navigator.pop(context);
      return 400;
    }
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
              padding: const EdgeInsets.only(left: 15),
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
              const SizedBox(height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 270,
                      height: 60,
                      child: Text(
                        'Уровень $level',
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context, builder: (context) => defectType == 1 ? HelpDialog1() : HelpDialog2());
                        },
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
                      const Text(
                        'Помощь',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
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
                    const SizedBox(height: 10),
                    word == null
                        ? const CircularProgressIndicator()
                        : Container(
                            height: 200,
                            width: 300,
                            alignment: const Alignment(0.0, -0.2),
                            child: SingleChildScrollView(
                              child: Text(
                                "$word",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.bold,
                                    color: Color(CustomColors.main),
                                    height: 1.2),
                              ),
                            ),
                          ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      width: 290,
                      child: Text(
                        'Произнесите слово вслух (постарайтесь уложиться в 7 с.), нажав на красную кнопку',
                        style: TextStyle(color: Colors.black26, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await player.togglePlaying(whenFinished: () {});

                      if (mounted)
                        setState(() {});
                      else
                        return;
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
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      if (recorder.isRecording) {
                        endTimer(false);
                      } else {
                        startTimer();
                      }
                      await recorder.toggleRecording();
                      Future.delayed(const Duration(milliseconds: 400), () => recorded = true);
                      if (mounted)
                        setState(() {});
                      else
                        return;
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
                  const SizedBox(width: 10),
                  Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Color(CustomColors.main), borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "$recordNum/3",
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                    gradient: ButtonGrad(),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(spreadRadius: 1, offset: Offset(0, 2), blurRadius: 2, color: Colors.black26)
                    ]),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () async {
                    // Проверка на то, что пользователь вкючал запись
                    if (recorded && !recorder.isRecording && !player.isPlaying) {
                      // формирование запроса
                      final response = await get_response(context);

                      // Сработал ли запрос
                      // нет
                      if (response == 400) {
                        log("<taskPage> Ошибка");

                        showModalBottomSheet(context: context, builder: (context) => AIInfoSheet(type: 'server_error'));

                        // да
                      } else {
                        // запись запроса в результат
                        result = response;
                        log("<taskPage> Результат модели - $result");

                        recorded = false;

                        // если дефект не совпадает с текущим, то считаем, что дефекта нет
                        if (result == null || result != defectType) {
                          result = 0;
                        }

                        results.add(result!); // добавление дефекта в список результатов модели
                        log("<taskPage> RESULTS ($results)");
                        // обработчик того, последняя ли попытка записи была
                        if (recordNum >= 3) {
                          startLevel();
                        } else {
                          recordNum += 1;
                        }
                        log("<taskPage> Номер записи $recordNum");
                      }
                      if (mounted)
                        setState(() {});
                      else
                        return;
                      // если пользователь не включал запись
                    } else {
                      if (!recorded)
                        showModalBottomSheet(context: context, builder: (context) => AIInfoSheet(type: 'no_record'));
                      else
                        showModalBottomSheet(context: context, builder: (context) => AIInfoSheet(type: 'in_process'));
                    }
                  },
                  child: const Text(
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
