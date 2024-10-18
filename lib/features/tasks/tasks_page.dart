// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/features/drawer.dart';
import 'package:ai_app/repositories/auth/auth_service.dart';
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
  final auth = AuthService();
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
        drawer: AppDrawer(chosen: 1),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
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
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu, color: Color(CustomColors.main), size: 30)),
            ),
            title: Center(
                child: Text(dbGetter?.getUser()?.username ?? '<Загрузка...>',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(CustomColors.main)))),
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        Navigator.of(context).pushNamed('/settings', arguments: user);
                      },
                      icon: Icon(Icons.settings, color: Color(CustomColors.main), size: 30)),
                  SizedBox(width: 10)
                ],
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            // Padding(
            //   padding: EdgeInsets.only(top: height / 11, left: width / 2),
            //   child: Transform.rotate(
            //       angle: 6 * math.pi / 12,
            //       child: Image.asset("images/hexagon.png",
            //           scale: 1.4, opacity: const AlwaysStoppedAnimation(0.05), alignment: Alignment.center))),

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
                  SizedBox(height: 50),
                  Column(
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
                  SizedBox(height: 50),
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
                          Navigator.of(context).pushNamed('/tasks/levels');
                        },
                        child: Container(
                            width: 330,
                            height: 80,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 15, right: 10),
                            decoration: BoxDecoration(
                                gradient: dbGetter?.getUser()?.username == null
                                    ? GreyTile()
                                    : dbGetter!.getUser()!.defect.contains('1')
                                        ? TileGrad1()
                                        : GreyTile(),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                                ]),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
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
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Задание ${dbGetter?.getUser()?.current_level["1"] ?? 0}/6',
                                        style:
                                            TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            )),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 330,
                        child: Text(
                          dbGetter?.getUser()?.username == null
                              ? 'Загрузка...'
                              : dbGetter!.getUser()!.defect.contains('1')
                                  ? 'Рекомендуется'
                                  : 'Не рекомендуется диагностикой',
                          style: TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 330,
                            height: 80,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 15, right: 10),
                            decoration: BoxDecoration(
                                gradient: dbGetter?.getUser()?.username == null
                                    ? GreyTile()
                                    : dbGetter!.getUser()!.defect.contains('2')
                                        ? TileGrad1()
                                        : GreyTile(),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                                ]),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
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
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Задание ${dbGetter?.getUser()?.current_level["2"] ?? 0}/6',
                                        style:
                                            TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            )),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 330,
                        child: Text(
                          dbGetter?.getUser()?.username == null
                              ? 'Загрузка...'
                              : dbGetter!.getUser()!.defect.contains('2')
                                  ? 'Рекомендуется'
                                  : 'Не рекомендуется диагностикой',
                          style: TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
