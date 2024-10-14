// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/models/user.dart';
import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = AuthService();
  final database = DatabaseService();
  User? user;
  List<dynamic>? users;
  GetValues? dbGetter;

  asyncGetter() async {
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
              child: IconButton(onPressed: null, icon: Icon(Icons.menu, color: Color(CustomColors.main), size: 30)),
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                dbGetter?.getUser() == null
                    ? SizedBox(width: 400, height: 200, child: CircularProgressIndicator())
                    : InformationField(
                        user: dbGetter!.getUser()!,
                        defectType: 0,
                      ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 480,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Меню",
                                  style: TextStyle(
                                      color: Color(CustomColors.main), fontSize: 25, fontWeight: FontWeight.w700)),
                              Container(
                                width: 335,
                                height: 1,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 85,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: TileGrad1(),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2, offset: Offset(0, 3), blurRadius: 4, color: Colors.black26)
                                      ]),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8, left: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Диагностика",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(height: 10),
                                            dbGetter?.getUser()?.isDiagnosed == null
                                                ? CircularProgressIndicator()
                                                : dbGetter!.getUser()!.isDiagnosed
                                                    ? Icon(Icons.check, color: Colors.white)
                                                    : Icon(Icons.cancel_outlined, color: Colors.white)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 48, right: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                dbGetter?.getUser()?.isDiagnosed == null
                                                    ? "Загрузка..."
                                                    : dbGetter!.getUser()!.isDiagnosed
                                                        ? "Уже пройдена!"
                                                        : "Еще не пройдена!",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 85,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: TileGrad3(),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2, offset: Offset(0, 3), blurRadius: 4, color: Colors.black26)
                                      ]),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8, left: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Редактор занятий",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(height: 10),
                                            dbGetter?.getUser()?.isDiagnosed == null
                                                ? CircularProgressIndicator()
                                                : dbGetter!.getUser()!.lessons.isEmpty
                                                    ? Icon(Icons.cancel_outlined, color: Colors.white)
                                                    : Icon(Icons.check, color: Colors.white)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 48, right: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                dbGetter?.getUser()?.isDiagnosed == null
                                                    ? "Загрузка..."
                                                    : dbGetter!.getUser()!.lessons.isEmpty
                                                        ? "Еще не пройден!"
                                                        : "Уже пройден!",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 85,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: TileGrad2(),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2, offset: Offset(0, 3), blurRadius: 4, color: Colors.black26)
                                      ]),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8, left: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Задания",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(height: 10),
                                            dbGetter?.getUser()?.isDiagnosed == null
                                                ? CircularProgressIndicator()
                                                : dbGetter!.getUser()!.lessons.isEmpty
                                                    ? Icon(Icons.cancel_outlined, color: Colors.white)
                                                    : Icon(Icons.check, color: Colors.white)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 48, right: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                dbGetter?.getUser()?.isDiagnosed == null
                                                    ? "Загрузка..."
                                                    : dbGetter!.getUser()!.lessons.isEmpty
                                                        ? "Недоступны!"
                                                        : "Пройдено {}", // !!! СОЕДИНИТЬ С БАЗОЙ ДАННЫХ
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InformationField extends StatefulWidget {
  final CustomUser user;
  final int defectType;
  const InformationField({super.key, required this.user, required this.defectType});

  @override
  State<InformationField> createState() => _InformationFieldState();
}

class _InformationFieldState extends State<InformationField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 400,
        color: Colors.transparent,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 155,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [
                      BoxShadow(spreadRadius: 2, offset: Offset(0, 3), blurRadius: 4, color: Colors.black26)
                    ]),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Прогресс за занятия",
                              style: TextStyle(color: Color(CustomColors.main), fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 70.0),
                              child: Container(
                                width: 60,
                                height: 32,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(CustomColors.mainLight), borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  widget.user.lessons.isEmpty ? '0%' : 'n%', // !!! СОЕДИНИТЬ С БАЗОЙ ДАННЫХ
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Container(
                    height: 100,
                    width: 155,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [
                      BoxShadow(spreadRadius: 2, offset: Offset(0, 3), blurRadius: 4, color: Colors.black26)
                    ]),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Процент усп. выполнения",
                              style: TextStyle(color: Color(CustomColors.main), fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 70.0),
                              child: Container(
                                width: 60,
                                height: 32,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(CustomColors.mainLight), borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  widget.user.lessons.isEmpty ? '0%' : 'n%', // !!! СОЕДИНИТЬ С БАЗОЙ ДАННЫХ
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Пройдено уроков: {}",
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                  ), // !!! СОЕДИНИТЬ С БАЗОЙ ДАННЫХ
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    height: 10,
                    width: 335,
                    child: LinearProgressIndicator(
                      value: 0.3, // !!! СОЕДИНИТЬ С БАЗОЙ ДАННЫХ
                      borderRadius: BorderRadius.circular(10),
                      color: Color(CustomColors.bright),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 335,
                    child: Text(
                      textAlign: TextAlign.end,
                      "Всего уроков: {}",
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
