// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:math' as math;
import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/features/auth/auth_error_hander.dart';
import 'package:ai_app/repositories/auth_service.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final auth = AuthService();

  String? username;
  String? email;
  String? password;

  void signUp(String em, String p) async {
    final user = await auth.createUserWithEmailAndPassword(em, p);

    if (user != null) {
      log("Пользователь создан");
      Navigator.of(context).pushNamed("/home", arguments: user);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Stack(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(top: height / 6, left: width / 30),
          //   child: Image.asset("images/hexagon.png",
          //       scale: 2,
          //       opacity: const AlwaysStoppedAnimation(0.1),
          //       alignment: Alignment.center),
          // ),
          Padding(
              padding: EdgeInsets.only(top: height / 1.65, left: width / 2.5),
              child: Transform.rotate(
                angle: 5 * math.pi / 12,
                child: Image.asset("images/triangle.png",
                    scale: 1.2,
                    opacity: const AlwaysStoppedAnimation(0.1),
                    alignment: Alignment.center),
              )),

          Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height:
                            (height - width) > 0 ? height / 7 : height / 10),
                    SizedBox(
                      height: 50,
                      child: Text(
                        "Регистрация",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            (height - width) > 0 ? height / 11 : height / 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ваш никнейм:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          height: 40,
                          width: 295,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              Icon(
                                Icons.account_circle_outlined,
                                size: 24,
                                color: Color(CustomColors.bright),
                              ),
                              SizedBox(width: 8),
                              SizedBox(
                                width: 250,
                                height: 40,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints:
                                        BoxConstraints.expand(width: 450),
                                    child: TextField(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: Colors.black87),
                                      maxLength: 25,
                                      onChanged: (value) => setState(() {
                                        username = value;
                                      }),
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 8),
                                        counterText: "",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Почта:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          height: 40,
                          width: 295,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              Icon(
                                Icons.mail_outline,
                                size: 24,
                                color: Color(CustomColors.bright),
                              ),
                              SizedBox(width: 8),
                              SizedBox(
                                width: 250,
                                height: 40,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints:
                                        BoxConstraints.expand(width: 450),
                                    child: TextField(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: Colors.black87),
                                      maxLength: 25,
                                      onChanged: (value) => setState(() {
                                        email = value;
                                      }),
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 12),
                                        counterText: "",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Пароль:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          height: 40,
                          width: 295,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              Icon(
                                Icons.key_outlined,
                                size: 24,
                                color: Color(CustomColors.bright),
                              ),
                              SizedBox(width: 8),
                              SizedBox(
                                width: 250,
                                height: 40,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints:
                                        BoxConstraints.expand(width: 450),
                                    child: TextField(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: Colors.black87),
                                      maxLength: 25,
                                      onChanged: (value) => setState(() {
                                        password = value;
                                      }),
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 12),
                                        counterText: "",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height:
                            (height - width) > 0 ? height / 11 : height / 18),
                    SizedBox(
                      height: 40,
                      width: 180,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(CustomColors.bright)),
                        onPressed: () async {
                          if (username == null || password == null) {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) =>
                                    const AuthDenySheet(type: "none"));
                          } else if (username!.length < 4 ||
                              password!.length < 4) {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) =>
                                    AuthDenySheet(type: "length"));
                          } else {
                            log("Логин: $username, пароль: $password");
                            signUp(username!, password!);
                          }
                        },
                        child: Text(
                          "Создать",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
