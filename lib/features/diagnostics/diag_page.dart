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

class DiagnosticsPage extends StatefulWidget {
  const DiagnosticsPage({super.key});

  @override
  State<DiagnosticsPage> createState() => _DiagnosticsPageState();
}

class _DiagnosticsPageState extends State<DiagnosticsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = AuthService();
  final database = DatabaseService();
  User? user;
  List<dynamic>? users;
  GetValues? dbGetter;

  void asyncGetter() async {
    await database.getUsers().listen((snapshot) {
      List<dynamic> users_tmp = snapshot.docs;
      dbGetter = GetValues(subject: "username", user: user!, users: users_tmp);
      setState(() {
        users = users_tmp;
      });
    });
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();

    asyncGetter();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Center(
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
                    onTap: () {},
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
                              dbGetter?.getUser()?.defect == null
                                  ? CircularProgressIndicator()
                                  : dbGetter!.getUser()!.defect.contains("1")
                                      ? Icon(Icons.cancel_outlined, color: Colors.white)
                                      : Icon(Icons.check, color: Colors.white),
                              SizedBox(
                                width: 110,
                                height: 20,
                                child: Text(
                                  dbGetter?.getUser()?.defect == null
                                      ? "Загрузка..."
                                      : dbGetter!.getUser()!.defect.contains("1")
                                          ? "Обнаружено!"
                                          : "не обнаружено",
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
                    onTap: () {},
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
                              dbGetter?.getUser()?.defect == null
                                  ? CircularProgressIndicator()
                                  : dbGetter!.getUser()!.defect.contains("2")
                                      ? Icon(Icons.cancel_outlined, color: Colors.white)
                                      : Icon(Icons.check, color: Colors.white),
                              SizedBox(
                                width: 110,
                                height: 20,
                                child: Text(
                                  dbGetter?.getUser()?.defect == null
                                      ? "Загрузка..."
                                      : dbGetter!.getUser()!.defect.contains("2")
                                          ? "Обнаружено!"
                                          : "не обнаружено",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.white, fontSize: 11),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
