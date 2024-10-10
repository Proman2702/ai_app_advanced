// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:developer';

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/models/user.dart';
import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:ai_app/repositories/database/database_service.dart';
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

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null) {
      user = args as User;
    }

    super.didChangeDependencies();
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
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: Colors.black,
            leadingWidth: 60,
            leading: Padding(
              padding: const EdgeInsets.only(top: 5, left: 5),
              child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.menu,
                    color: Color(CustomColors.main),
                    size: 30,
                  )),
            ),
            title: Center(
              child: StreamBuilder(
                  stream: database.getUsers(),
                  builder: (context, snapshot) {
                    List users = snapshot.data?.docs ?? [];

                    for (var i in users) {
                      if (i.id == user!.email) {
                        return Text(
                          "${i.data().username}",
                          style: TextStyle(
                              color: Color(CustomColors.main),
                              fontWeight: FontWeight.w700,
                              fontSize: 25),
                        );
                      }
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color(CustomColors.mainLightX2)),
                    );
                  }),
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        //await auth.signOut();
                        Navigator.of(context).pushNamed('/settings');
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Color(CustomColors.main),
                        size: 30,
                      )),
                  SizedBox(width: 10)
                ],
              ),
            ],
          ),
        ),
        body: Center(),
      ),
    );
  }
}
