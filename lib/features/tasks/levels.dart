// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/features/settings/confirmation_dialog.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LevelsMenu extends StatefulWidget {
  const LevelsMenu({super.key});

  @override
  State<LevelsMenu> createState() => _LevelsMenuState();
}

class _LevelsMenuState extends State<LevelsMenu> {
  late int defectType;
  final database = DatabaseService();
  User? user;
  List<dynamic>? users;
  GetValues? dbGetter;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    database.getUsers().listen((snapshot) {
      List<dynamic> users = snapshot.docs;
      dbGetter = GetValues(user: user!, users: users);
      setState(() {});
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments; //NULL CHECK VALUE
    defectType = args as int;
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
              SizedBox(height: 40),
              SizedBox(
                  width: 320,
                  child: Text(
                    'Курс по коррекции ${defectType == 1 ? 'картавости' : 'фрикативного "г"'}',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 1 уровень ВСЕГДА ОТКРЫТ
                      GestureDetector(
                        onTap: () {
                          log("1 уровень");
                          // Проверка если текущий уровень больше этого
                        },
                        child: Container(
                          height: 105,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Уровень 1',
                                  style: TextStyle(
                                      color: Color(CustomColors.main),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'nunito')),
                              SizedBox(height: 10),
                              Icon(
                                dbGetter?.getUser()?.current_level == null
                                    ? Icons.lock
                                    : dbGetter!.getUser()!.current_level['$defectType'] == 0 ||
                                            dbGetter!.getUser()!.current_level['$defectType'] == 1
                                        ? Icons.timer_outlined
                                        : dbGetter!.getUser()!.current_level['$defectType'] > 1
                                            ? Icons.check
                                            : Icons.lock,
                                color: Color(CustomColors.main),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Тренировка звуков',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 2 уровень
                      GestureDetector(
                        onTap: dbGetter?.getUser()?.current_level == null
                            ? () {}
                            : dbGetter!.getUser()!.current_level['$defectType'] >= 2
                                ? () {
                                    log('2 уровень');
                                    // Проверка если текущий уровень больше этого
                                  }
                                : () {},
                        child: Container(
                          height: 105,
                          width: 150,
                          decoration: BoxDecoration(
                              color: dbGetter?.getUser()?.current_level == null
                                  ? Colors.grey
                                  : dbGetter!.getUser()!.current_level['$defectType'] >= 2
                                      ? Colors.white
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Уровень 2',
                                  style: TextStyle(
                                      color: Color(CustomColors.main),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'nunito')),
                              SizedBox(height: 10),
                              Icon(
                                dbGetter?.getUser()?.current_level == null
                                    ? Icons.lock
                                    : dbGetter!.getUser()!.current_level['$defectType'] == 2
                                        ? Icons.timer_outlined
                                        : dbGetter!.getUser()!.current_level['$defectType'] > 2
                                            ? Icons.check
                                            : Icons.lock,
                                color: Color(CustomColors.main),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Тренировка слогов',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 3 уровень
                      GestureDetector(
                        onTap: dbGetter?.getUser()?.current_level == null
                            ? () {}
                            : dbGetter!.getUser()!.current_level['$defectType'] >= 3
                                ? () {
                                    log('3 уровень');
                                    // Проверка если текущий уровень больше этого
                                  }
                                : () {},
                        child: Container(
                          height: 105,
                          width: 150,
                          decoration: BoxDecoration(
                              color: dbGetter?.getUser()?.current_level == null
                                  ? Colors.grey
                                  : dbGetter!.getUser()!.current_level['$defectType'] >= 3
                                      ? Colors.white
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Уровень 3',
                                  style: TextStyle(
                                      color: Color(CustomColors.main),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'nunito')),
                              SizedBox(height: 10),
                              Icon(
                                dbGetter?.getUser()?.current_level == null
                                    ? Icons.lock
                                    : dbGetter!.getUser()!.current_level['$defectType'] == 3
                                        ? Icons.timer_outlined
                                        : dbGetter!.getUser()!.current_level['$defectType'] > 3
                                            ? Icons.check
                                            : Icons.lock,
                                color: Color(CustomColors.main),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Тренировка слов\n',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 4 уровень
                      GestureDetector(
                        onTap: dbGetter?.getUser()?.current_level == null
                            ? () {}
                            : dbGetter!.getUser()!.current_level['$defectType'] >= 4
                                ? () {
                                    log('4 уровень');
                                    // Проверка если текущий уровень больше этого
                                  }
                                : () {},
                        child: Container(
                          height: 105,
                          width: 150,
                          decoration: BoxDecoration(
                              color: dbGetter?.getUser()?.current_level == null
                                  ? Colors.grey
                                  : dbGetter!.getUser()!.current_level['$defectType'] >= 4
                                      ? Colors.white
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Уровень 4',
                                  style: TextStyle(
                                      color: Color(CustomColors.main),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'nunito')),
                              SizedBox(height: 10),
                              Icon(
                                dbGetter?.getUser()?.current_level == null
                                    ? Icons.lock
                                    : dbGetter!.getUser()!.current_level['$defectType'] == 4
                                        ? Icons.timer_outlined
                                        : dbGetter!.getUser()!.current_level['$defectType'] > 4
                                            ? Icons.check
                                            : Icons.lock,
                                color: Color(CustomColors.main),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Тренировка \nсловосочетаний',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 5 уровень
                      GestureDetector(
                        onTap: dbGetter?.getUser()?.current_level == null
                            ? () {}
                            : dbGetter!.getUser()!.current_level['$defectType'] >= 5
                                ? () {
                                    log('5 уровень');
                                    // Проверка если текущий уровень больше этого
                                  }
                                : () {},
                        child: Container(
                          height: 105,
                          width: 150,
                          decoration: BoxDecoration(
                              color: dbGetter?.getUser()?.current_level == null
                                  ? Colors.grey
                                  : dbGetter!.getUser()!.current_level['$defectType'] >= 5
                                      ? Colors.white
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Уровень 5',
                                  style: TextStyle(
                                      color: Color(CustomColors.main),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'nunito')),
                              SizedBox(height: 10),
                              Icon(
                                dbGetter?.getUser()?.current_level == null
                                    ? Icons.lock
                                    : dbGetter!.getUser()!.current_level['$defectType'] == 5
                                        ? Icons.timer_outlined
                                        : dbGetter!.getUser()!.current_level['$defectType'] > 5
                                            ? Icons.check
                                            : Icons.lock,
                                color: Color(CustomColors.main),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Тренировка \nскороговорок',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 6 уровень
                      GestureDetector(
                        onTap: dbGetter?.getUser()?.current_level == null
                            ? () {}
                            : dbGetter!.getUser()!.current_level['$defectType'] >= 6
                                ? () {
                                    log('6 уровень');
                                    // Проверка если текущий уровень больше этого
                                  }
                                : () {},
                        child: Container(
                          height: 105,
                          width: 150,
                          decoration: BoxDecoration(
                              color: dbGetter?.getUser()?.current_level == null
                                  ? Colors.grey
                                  : dbGetter!.getUser()!.current_level['$defectType'] >= 6
                                      ? Colors.white
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Уровень 6',
                                  style: TextStyle(
                                      color: Color(CustomColors.main),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'nunito')),
                              SizedBox(height: 10),
                              Icon(
                                dbGetter?.getUser()?.current_level == null
                                    ? Icons.lock
                                    : dbGetter!.getUser()!.current_level['$defectType'] == 6
                                        ? Icons.timer_outlined
                                        : dbGetter!.getUser()!.current_level['$defectType'] > 6
                                            ? Icons.check
                                            : Icons.lock,
                                color: Color(CustomColors.main),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Контрольный\n',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30),
              Container(
                height: 40,
                width: 210,
                decoration: BoxDecoration(gradient: ButtonGrad(), borderRadius: BorderRadius.circular(20), boxShadow: [
                  BoxShadow(spreadRadius: 1, offset: Offset(0, 2), blurRadius: 2, color: Colors.black26)
                ]),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                            info: "Вы уверены, что хотите очистить курс?",
                            action: () {
                              // ЗАПОЛНИТЬ ФУНКЦИЮ УДАЛЕНИЯ
                            }));
                  },
                  child: Text(
                    "Сбросить курс",
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
