// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables
import 'package:ai_app/features/named_appbar.dart';
import 'package:ai_app/features/home/information_tile.dart';
import 'package:ai_app/etc/models/defects.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/repositories/auth/firebase/firebase_auth_service.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/features/drawer.dart';
import 'package:ai_app/etc/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:developer';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final database = DatabaseService();
  User? user;
  GetValues? dbGetter;
  Map? defects;

  @override
  void initState() {
    defects = Defects.getAll();
    user = FirebaseAuth.instance.currentUser;
    database.getUsers().listen((snapshot) {
      List<dynamic> users = snapshot.docs;
      dbGetter = GetValues(user: user!, users: users);
      setState(() {});
    });
    super.initState();
  }

  // Построение вкладок статистики
  List<Widget> buildTiles() {
    List<Widget> tiles = [];
    defects!.forEach((i, value) {
      tiles.add(
        InformationField(
          user: dbGetter!.getUser()!,
          defectType: [i, value],
        ),
      );
    });
    return tiles;
  }

  // Условие наличия дефектов в диагностике
  bool defectsDiagExisting() {
    int counter = 0;
    defects!.forEach((i, value) {
      if (dbGetter!.getUser()!.defects[i] != 0) {
        counter += 1;
      }
    });
    return counter == defects!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        drawer: AppDrawer(chosen: 0),
        appBar: NamedAppBar(scaffoldKey: _scaffoldKey, dbGetter: dbGetter, user: user),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                dbGetter?.getUser() == null
                    ? Container(
                        width: 320, height: 320, padding: EdgeInsets.all(140), child: CircularProgressIndicator())
                    : CarouselSlider(
                        items: buildTiles(),
                        options: CarouselOptions(
                          height: 320.0,
                          enlargeCenterPage: false,
                          autoPlay: false,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                        ),
                      ),
                SizedBox(height: 10),
                Container(
                  height: 360,
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
                              Container(width: 335, height: 1, color: Colors.black26)
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/diagnostics');
                                },
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
                                            dbGetter?.getUser()?.defects == null
                                                ? SizedBox(height: 25, width: 25, child: CircularProgressIndicator())
                                                : !defectsDiagExisting()
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
                                                dbGetter?.getUser()?.defects == null
                                                    ? "Загрузка..."
                                                    : !defectsDiagExisting()
                                                        ? "Еще не пройдена!"
                                                        : "Пройдена!",
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
                                onTap: () {
                                  Navigator.of(context).pushNamed('/tasks');
                                },
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
                                            dbGetter?.getUser()?.current_level == null
                                                ? SizedBox(height: 25, width: 25, child: CircularProgressIndicator())
                                                : dbGetter!.getUser()!.current_level.isEmpty
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
                                                dbGetter?.getUser()?.current_level == null
                                                    ? "Загрузка..."
                                                    : dbGetter!.getUser()!.current_level.isEmpty
                                                        ? "Прохождение не начато!"
                                                        : "В процессе: ${dbGetter!.getUser()!.current_level.length} курса", // !!! СОЕДИНИТЬ С БАЗОЙ ДАННЫХ
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
