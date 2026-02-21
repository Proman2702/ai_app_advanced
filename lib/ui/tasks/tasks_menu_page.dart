// ignore_for_file: unused_import

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/ui/diagnostics/diag_menu_tile.dart';
import 'package:ai_app/ui/drawer.dart';
import 'package:ai_app/ui/named_appbar.dart';
import 'package:ai_app/ui/tasks/tasks_menu_tile.dart';
import 'package:ai_app/models/defects.dart';
import 'package:ai_app/repositories/database/firebase/firebase_users_database.dart';
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
  Map? defects;

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

  List<Widget> buildTiles() {
    List<Widget> tiles = [];
    Map defects = Defects.getAll();
    defects.forEach((i, value) {
      tiles.add(
        TasksMenuTile(
          dbGetter: dbGetter,
          defectType: [i, value],
        ),
      );
      tiles.add(const SizedBox(height: 10));
    });
    return tiles;
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
            SingleChildScrollView(
              child: Center(
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
                      children: buildTiles(),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
