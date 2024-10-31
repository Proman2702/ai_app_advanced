// ignore_for_file: unused_import

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/features/drawer.dart';
import 'package:ai_app/features/named_appbar.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const AppDrawer(chosen: 1),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: NamedAppBar(scaffoldKey: _scaffoldKey, dbGetter: dbGetter, user: user),
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(top: height / 1.53, left: width / 2),
                child: Transform.rotate(
                    angle: 0 * math.pi / 12,
                    child: Image.asset("images/hexagon_grad.png",
                        scale: 1.95, opacity: const AlwaysStoppedAnimation(0.2), alignment: Alignment.center))),
            Padding(
                padding: EdgeInsets.only(top: height / 1.65, left: width / 2.8),
                child: Transform.rotate(
                    angle: 0 * math.pi / 12,
                    child: Image.asset("images/hexagon_grad.png",
                        scale: 1.95, opacity: const AlwaysStoppedAnimation(0.2), alignment: Alignment.center))),
            Padding(
                padding: EdgeInsets.only(top: height / 1.55, left: width / 7),
                child: Transform.rotate(
                    angle: 0 * math.pi / 12,
                    child: Image.asset("images/hexagon_grad.png",
                        scale: 1.5, opacity: const AlwaysStoppedAnimation(0.4), alignment: Alignment.center))),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 330,
                        height: 45,
                        child: Text(
                          "Задания",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 330,
                        height: 45,
                        child: Text(
                          "для",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 330,
                        height: 45,
                        child: Text(
                          "прохождения",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   width: 330,
                      //   child: Text(
                      //     'Всего загружено 2 дефекта',
                      //     style: TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 330,
                      //   child: Text(
                      //     'Нажмите на вкладку, чтобы пройти диагностику',
                      //     style: TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
                      //   ),
                      // ),
                      // SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/tasks/levels', arguments: 1);
                        },
                        child: Container(
                            width: 330,
                            height: 80,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 15, right: 10),
                            decoration: BoxDecoration(
                                gradient: dbGetter?.getUser()?.defects == null
                                    ? GreyTile()
                                    : dbGetter!.getUser()!.defects['1'] == 2
                                        ? TileGrad1()
                                        : GreyTile(),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                                ]),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Коррекция картавости',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'nunito'))
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Задание ${dbGetter?.getUser()?.current_level["1"] ?? 0}/6',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            )),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 330,
                        child: Text(
                          dbGetter?.getUser()?.defects == null
                              ? 'Загрузка...'
                              : dbGetter!.getUser()!.defects['1'] == 1
                                  ? 'Не рекомендуется диагностикой'
                                  : dbGetter!.getUser()!.defects['1'] == 2
                                      ? 'Рекомендуется'
                                      : 'Диагностика не пройдена',
                          style: const TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/tasks/levels', arguments: 2);
                        },
                        child: Container(
                            width: 330,
                            height: 80,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 15, right: 10),
                            decoration: BoxDecoration(
                                gradient: dbGetter?.getUser()?.defects == null
                                    ? GreyTile()
                                    : dbGetter!.getUser()!.defects['2'] == 2
                                        ? TileGrad1()
                                        : GreyTile(),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                                ]),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Коррекция "Г"',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'nunito'))
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Задание ${dbGetter?.getUser()?.current_level["2"] ?? 0}/6',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            )),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 330,
                        child: Text(
                          dbGetter?.getUser()?.defects == null
                              ? 'Загрузка...'
                              : dbGetter!.getUser()!.defects['2'] == 1
                                  ? 'Не рекомендуется диагностикой'
                                  : dbGetter!.getUser()!.defects['2'] == 2
                                      ? 'Рекомендуется'
                                      : 'Диагностика не пройдена',
                          style: const TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
