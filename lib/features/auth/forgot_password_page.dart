// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:math' as math;
import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/features/auth/auth_error_hander.dart';
import 'package:ai_app/features/auth/email_notificator.dart';
import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? email;
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Stack(
        children: [
          Padding(
              padding: EdgeInsets.only(top: height / 1.6, left: width / 2.3),
              child: Transform.rotate(
                angle: 5 * math.pi / 12,
                child: Image.asset("images/triangle.png",
                    scale: 1.2, opacity: const AlwaysStoppedAnimation(0.15), alignment: Alignment.center),
              )),
          Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    SizedBox(height: (height - width) > 0 ? height / 7 : height / 10),
                    Center(
                      child: SizedBox(
                        height: 110,
                        width: 295,
                        child: Text(
                          "Восстановление пароля",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: (height - width) > 0 ? height / 10 : height / 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 250,
                          child: Text(
                            "Введите почту, к которой привязывали аккаунт",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 295,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              Icon(
                                Icons.mail_outline_outlined,
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
                                    constraints: BoxConstraints.expand(width: 450),
                                    child: TextField(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87),
                                      maxLength: 25,
                                      onChanged: (value) => setState(() {
                                        email = value;
                                      }),
                                      decoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        contentPadding: EdgeInsets.only(bottom: 8),
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
                    SizedBox(height: (height - width) > 0 ? height / 6 : height / 10),
                    Container(
                      height: 40,
                      width: 220,
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
                        onPressed: () async {
                          if (email == null) {
                            showModalBottomSheet(
                                context: context, builder: (BuildContext context) => const AuthDenySheet(type: "none"));
                          } else {
                            log("Почта: $email");
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: new AlwaysStoppedAnimation<Color>(Color(CustomColors.mainLightX2)),
                                    ),
                                  );
                                });
                            final result = await auth.resetPassword(email!);
                            Navigator.of(context).pop();
                            if (result[0] == 0) {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context, builder: (BuildContext context) => EmailNotificator(type: "sent"));
                            } else {
                              showModalBottomSheet(
                                  context: context, builder: (BuildContext context) => AuthDenySheet(type: result[1]));
                            }
                          }
                        },
                        child: Text(
                          "Восстановить",
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
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
