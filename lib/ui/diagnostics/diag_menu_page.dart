// ignore_for_file: unused_import

import 'package:ai_app/etc/colors/colors.dart';
import 'dart:math' as math;
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/ui/diagnostics/diag_menu_tile.dart';
import 'package:ai_app/ui/drawer.dart';
import 'package:ai_app/ui/named_appbar.dart';
import 'package:ai_app/models/defects.dart';
import 'package:ai_app/repositories/database/firebase/firebase_users_database.dart';
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

  List<Widget> buildTiles() {
    List<Widget> tiles = [];
    Map defects = Defects.getAll();
    defects.forEach((i, value) {
      tiles.add(
        DiagTile(
          dbGetter: dbGetter,
          defectType: [i, value],
        ),
      );
      tiles.add(const SizedBox(height: 18));
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
        resizeToAvoidBottomInset: true,
        drawer: const AppDrawer(chosen: 2),
        backgroundColor: Colors.transparent,
        appBar: NamedAppBar(scaffoldKey: _scaffoldKey, dbGetter: dbGetter, user: user),
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(top: height / 18, left: width / 1.8),
                child: Transform.rotate(
                    angle: 6 * math.pi / 12,
                    child: Image.asset("images/hexagon.png",
                        scale: 1.6, opacity: const AlwaysStoppedAnimation(0.05), alignment: Alignment.center))),
            Padding(
                padding: EdgeInsets.only(top: height / 1.46, left: width / 4.5),
                child: Transform.rotate(
                    angle: 0 * math.pi / 12,
                    child: Image.asset("images/hexagon_grad.png",
                        scale: 1.7, opacity: const AlwaysStoppedAnimation(0.2), alignment: Alignment.center))),
            Padding(
                padding: EdgeInsets.only(top: height / 1.38, left: width / 2.3),
                child: Transform.rotate(
                    angle: 0 * math.pi / 12,
                    child: Image.asset("images/hexagon_grad.png",
                        scale: 1.9, opacity: const AlwaysStoppedAnimation(0.2), alignment: Alignment.center))),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 330,
                          height: 100,
                          child: Text("Диагностика речи",
                              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 65),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 330,
                          child: Text(
                            'Всего загружено ${defects!.length} дефекта(-ов)',
                            style: const TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          width: 330,
                          child: Text(
                            'Нажмите на вкладку, чтобы пройти диагностику',
                            style: TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: buildTiles(),
                        )
                      ],
                    ),
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
