// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ai_app/etc/colors/colors.dart';
import 'dart:math' as math;
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/features/drawer.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiagnosticsPage extends StatefulWidget {
  const DiagnosticsPage({super.key});

  @override
  State<DiagnosticsPage> createState() => _DiagnosticsPageState();
}

class _DiagnosticsPageState extends State<DiagnosticsPage> {
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
        resizeToAvoidBottomInset: true,
        drawer: AppDrawer(chosen: 2),
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
            Padding(
                padding: EdgeInsets.only(top: height / 11, left: width / 2),
                child: Transform.rotate(
                    angle: 6 * math.pi / 12,
                    child: Image.asset("images/hexagon.png",
                        scale: 1.4, opacity: const AlwaysStoppedAnimation(0.05), alignment: Alignment.center))),
            Padding(
                padding: EdgeInsets.only(top: height / 1.5, left: width / 12),
                child: Transform.rotate(
                    angle: 0 * math.pi / 12,
                    child: Image.asset("images/hexagon_grad.png",
                        scale: 1.7, opacity: const AlwaysStoppedAnimation(0.2), alignment: Alignment.center))),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 330,
                        height: 100,
                        child: Text(
                          "Диагностика речи",
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 90),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 330,
                        child: Text(
                          'Всего загружено 2 дефекта',
                          style: TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 330,
                        child: Text(
                          'Нажмите на вкладку, чтобы пройти диагностику',
                          style: TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/diagnostics/level', arguments: 1);
                        },
                        child: Container(
                          width: 330,
                          height: 60,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 15, right: 5),
                          decoration: BoxDecoration(
                              gradient: TileGrad1(),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 195,
                                child: Text(
                                  'Дефект 1 - картавость',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 5),
                                  dbGetter?.getUser()?.defects == null
                                      ? CircularProgressIndicator()
                                      : dbGetter!.getUser()!.defects['1'] == 1
                                          ? Icon(Icons.check, color: Colors.white)
                                          : Icon(Icons.cancel_outlined, color: Colors.white),
                                  SizedBox(
                                    width: 110,
                                    height: 20,
                                    child: Text(
                                      dbGetter?.getUser()?.defects == null
                                          ? "Загрузка..."
                                          : dbGetter!.getUser()!.defects['1'] == 0
                                              ? "Еще не выполнено!"
                                              : dbGetter!.getUser()!.defects['1'] == 2
                                                  ? "Обнаружено"
                                                  : "Не обнаружено",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.white, fontSize: 11),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/diagnostics/level', arguments: 1);
                        },
                        child: Container(
                          width: 330,
                          height: 60,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 15, right: 5),
                          decoration: BoxDecoration(
                              gradient: TileGrad1(),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 195,
                                child: Text(
                                  'Дефект 2 - г',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 5),
                                  dbGetter?.getUser()?.defects == null
                                      ? CircularProgressIndicator()
                                      : dbGetter!.getUser()!.defects['2'] == 1
                                          ? Icon(Icons.check, color: Colors.white)
                                          : Icon(Icons.cancel_outlined, color: Colors.white),
                                  SizedBox(
                                    width: 110,
                                    height: 20,
                                    child: Text(
                                      dbGetter?.getUser()?.defects == null
                                          ? "Загрузка..."
                                          : dbGetter!.getUser()!.defects['2'] == 0
                                              ? "Еще не выполнено!"
                                              : dbGetter!.getUser()!.defects['2'] == 2
                                                  ? "Обнаружено"
                                                  : "Не обнаружено",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.white, fontSize: 11),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  Container(
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                        gradient: ButtonGrad(),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(spreadRadius: 1, offset: Offset(0, 2), blurRadius: 2, color: Colors.black26)
                        ]),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Создать",
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
