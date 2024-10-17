// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ai_app/etc/colors/colors.dart';
import 'dart:math' as math;
import 'package:ai_app/etc/colors/gradients/drawer.dart';
import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  final int chosen;

  const AppDrawer({super.key, required this.chosen});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final double spacing = 10;

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
    return Drawer(
      width: 270,
      elevation: 20,
      child: Container(
        decoration: BoxDecoration(gradient: DrawerGrad()),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Text('AI App', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Container(
                height: 100,
                width: 230,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    color: Color(CustomColors.mainLight),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, offset: Offset(0, 3), spreadRadius: 1, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dbGetter?.getUser()?.username == null
                      ? [CircularProgressIndicator()]
                      : [
                          Text("${dbGetter!.getUser()!.username}",
                              style: TextStyle(
                                  color: Color(CustomColors.bright),
                                  fontFamily: 'nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          Text(
                            "${dbGetter!.getUser()!.email}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 140,
                height: 3,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (widget.chosen != 0) {
                    Navigator.of(context).pushNamed('/');
                  }
                },
                child: Container(
                  width: 230,
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.chosen == 0 ? Colors.white24 : Colors.transparent),
                  child: Row(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Главное меню",
                        style: TextStyle(
                            fontFamily: 'nunito', fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: spacing),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (widget.chosen != 1) {
                    Navigator.of(context).pushNamed('/tasks');
                  }
                },
                child: Container(
                  width: 230,
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.chosen == 1 ? Colors.white24 : Colors.transparent),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Задания",
                        style: TextStyle(
                            fontFamily: 'nunito', fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: spacing),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (widget.chosen != 2) {
                    Navigator.of(context).pushNamed('/diagnostics');
                  }
                },
                child: Container(
                  width: 230,
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.chosen == 2 ? Colors.white24 : Colors.transparent),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Диагностика",
                        style: TextStyle(
                            fontFamily: 'nunito', fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: spacing),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (widget.chosen != 3) {
                    Navigator.of(context).pushNamed('/settings');
                  }
                },
                child: Container(
                  width: 230,
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.chosen == 3 ? Colors.white24 : Colors.transparent),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Настройки",
                        style: TextStyle(
                            fontFamily: 'nunito', fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: spacing),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (widget.chosen != 0) {
                    Navigator.of(context).pushNamed('/');
                  }
                },
                child: Container(
                  width: 230,
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.chosen == 4 ? Colors.white24 : Colors.transparent),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chat_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "О приложении",
                        style: TextStyle(
                            fontFamily: 'nunito', fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Transform.rotate(
                        angle: 2 * math.pi,
                        child: Image.asset("images/hexagon_grad.png",
                            scale: 1.5, opacity: const AlwaysStoppedAnimation(0.5), alignment: Alignment.center),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
