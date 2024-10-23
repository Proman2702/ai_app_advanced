// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'dart:developer';

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/features/auth/auth_error_hander.dart';
import 'package:ai_app/features/settings/confirmation_dialog.dart';
import 'package:ai_app/features/auth/auth_formats.dart';
import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:ai_app/repositories/server/ip.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? user;
  String? password;
  String? newPassword;
  String? newPassword2;
  String? newIp;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null) {
      user = args as User;
    }

    super.didChangeDependencies();
  }

  final auth = AuthService();
  final database = DatabaseService();

  void signOut() async {
    await auth.signOut();
    Navigator.of(context).pushReplacementNamed("/");
  }

  void deleteAccount(email, password) async {
    final res = await auth.deleteAccount(email, password);

    if (res[0] == 0) {
      await database.deleteUser(email);

      Navigator.of(context).pushReplacementNamed("/");
    } else {
      showModalBottomSheet(context: context, builder: (BuildContext context) => AuthDenySheet(type: res[1]));
    }
  }

  void changePassword(email, password, newPassword) async {
    final res = await auth.changePassword(email, password, newPassword);

    if (res[0] == 0) {
      showModalBottomSheet(context: context, builder: (BuildContext context) => AuthDenySheet(type: "success"));
    } else {
      showModalBottomSheet(context: context, builder: (BuildContext context) => AuthDenySheet(type: res[1]));
    }
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
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(CustomColors.main),
                    size: 30,
                  )),
            ),
            title: Center(
                child: Text(
              "Настройки",
              style: TextStyle(color: Color(CustomColors.main), fontWeight: FontWeight.w700, fontSize: 25),
            )),
            actions: [SizedBox(width: 50)],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Text(
                        "Аккаунт",
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(height: 1, width: 330, color: Colors.black12),
                    SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Введите ваш текущий пароль и тот, на который хотите изменить его",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 295,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(),
                                            color: Colors.white),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 8),
                                            Icon(Icons.remove, size: 24, color: Color(CustomColors.bright)),
                                            SizedBox(width: 8),
                                            SizedBox(
                                              width: 210,
                                              height: 40,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints.expand(
                                                      width: AuthSettings().maxPasswordLength * 18),
                                                  child: TextField(
                                                    obscureText: false,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Colors.black87),
                                                    maxLength: AuthSettings().maxPasswordLength,
                                                    onChanged: (value) => setState(() {
                                                      password = value;
                                                    }),
                                                    decoration: InputDecoration(
                                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      contentPadding: EdgeInsets.only(bottom: 12),
                                                      counterText: "",
                                                      border: InputBorder.none,
                                                      labelText: "Старый пароль",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black12,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 40,
                                        width: 295,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(),
                                            color: Colors.white),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 8),
                                            Icon(Icons.add, size: 24, color: Color(CustomColors.bright)),
                                            SizedBox(width: 8),
                                            SizedBox(
                                              width: 210,
                                              height: 40,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints.expand(
                                                      width: AuthSettings().maxPasswordLength * 18),
                                                  child: TextField(
                                                    obscureText: false,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Colors.black87),
                                                    maxLength: AuthSettings().maxPasswordLength,
                                                    onChanged: (value) => setState(() {
                                                      newPassword = value;
                                                    }),
                                                    decoration: InputDecoration(
                                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      contentPadding: EdgeInsets.only(bottom: 12),
                                                      counterText: "",
                                                      border: InputBorder.none,
                                                      labelText: "Новый пароль",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black12,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 40,
                                        width: 295,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(),
                                            color: Colors.white),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 8),
                                            Icon(Icons.add, size: 24, color: Color(CustomColors.bright)),
                                            SizedBox(width: 8),
                                            SizedBox(
                                              width: 210,
                                              height: 40,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints.expand(
                                                      width: AuthSettings().maxPasswordLength * 18),
                                                  child: TextField(
                                                    obscureText: false,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Colors.black87),
                                                    maxLength: AuthSettings().maxPasswordLength,
                                                    onChanged: (value) => setState(() {
                                                      newPassword2 = value;
                                                    }),
                                                    decoration: InputDecoration(
                                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      contentPadding: EdgeInsets.only(bottom: 12),
                                                      counterText: "",
                                                      border: InputBorder.none,
                                                      labelText: "Повторите пароль",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black12,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actionsPadding: EdgeInsets.only(bottom: 20),
                                  actions: [
                                    SizedBox(
                                      height: 35,
                                      width: 130,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(CustomColors.main),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                          onPressed: () {
                                            if (password == null) {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext context) => AuthDenySheet(
                                                        type: "none",
                                                      ));
                                            } else if (newPassword != newPassword2) {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext context) => AuthDenySheet(
                                                        type: "not_equal",
                                                      ));
                                            } else {
                                              log("$user");
                                              changePassword(user!.email, password!, newPassword!);
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text("Сменить",
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700))),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 90,
                            width: 155,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(offset: Offset(0, 3), blurRadius: 5, spreadRadius: 1, color: Colors.black26)
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0, left: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 80,
                                    child: Text(
                                      "Сменить пароль",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          color: Color(CustomColors.main),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0, left: 5),
                                    child: Icon(Icons.lock_open_outlined, size: 45, color: Color(CustomColors.main)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  ConfirmationDialog(info: "Вы уверены, что хотите выйти?", action: signOut),
                            );
                          },
                          child: Container(
                            height: 90,
                            width: 155,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(offset: Offset(0, 3), blurRadius: 5, spreadRadius: 1, color: Colors.black26)
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0, left: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 80,
                                    child: Text(
                                      "Выйти из профиля",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          color: Color(CustomColors.main),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0, left: 5),
                                    child: Icon(Icons.meeting_room, size: 50, color: Color(CustomColors.main)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Повторно введите пароль, чтобы подтвердить удаление",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                                ),
                                content: Container(
                                  height: 40,
                                  width: 295,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 8),
                                      Icon(Icons.key_outlined, size: 24, color: Color(CustomColors.bright)),
                                      SizedBox(width: 8),
                                      SizedBox(
                                        width: 210,
                                        height: 40,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: ConstrainedBox(
                                            constraints:
                                                BoxConstraints.expand(width: AuthSettings().maxPasswordLength * 18),
                                            child: TextField(
                                              obscureText: false,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87),
                                              maxLength: AuthSettings().maxPasswordLength,
                                              onChanged: (value) => setState(() {
                                                password = value;
                                              }),
                                              decoration: InputDecoration(
                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                                contentPadding: EdgeInsets.only(bottom: 12),
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
                                actionsAlignment: MainAxisAlignment.center,
                                actionsPadding: EdgeInsets.only(bottom: 20),
                                actions: [
                                  SizedBox(
                                    height: 35,
                                    width: 130,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(CustomColors.main),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                        onPressed: () {
                                          if (password == null) {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) => AuthDenySheet(
                                                      type: "none",
                                                    ));
                                          } else {
                                            log("$user");
                                            deleteAccount(user!.email, password!);
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text("Удалить",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700))),
                                  ),
                                ],
                              );
                            },
                          ),
                          child: Container(
                            height: 90,
                            width: 155,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(offset: Offset(0, 3), blurRadius: 5, spreadRadius: 1, color: Colors.black26)
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0, left: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 80,
                                    child: Text(
                                      "Удалить аккаунт",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          color: Color(CustomColors.delete),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0, left: 5),
                                    child: Icon(Icons.delete_outlined, size: 45, color: Color(CustomColors.delete)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                            height: 90, width: 155, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20))),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    height: 40,
                    child: Text(
                      "Сервер",
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(height: 1, width: 330, color: Colors.black12),
                  SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: Text(
                                        "Введите новый IP-адрес или сбросьте его",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                                      ),
                                      content: Container(
                                        height: 40,
                                        width: 295,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(),
                                            color: Colors.white),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 8),
                                            Icon(Icons.add, size: 24, color: Color(CustomColors.bright)),
                                            SizedBox(width: 8),
                                            SizedBox(
                                              width: 210,
                                              height: 40,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints.expand(width: 1000),
                                                  child: TextField(
                                                    obscureText: false,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Colors.black87),
                                                    maxLength: 70,
                                                    onChanged: (value) => setState(() {
                                                      newIp = value;
                                                    }),
                                                    decoration: InputDecoration(
                                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      contentPadding: EdgeInsets.only(bottom: 12),
                                                      counterText: "",
                                                      border: InputBorder.none,
                                                      labelText: "Новый IP",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black12,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actionsAlignment: MainAxisAlignment.center,
                                      actionsPadding: EdgeInsets.only(bottom: 20),
                                      actions: [
                                        SizedBox(
                                          height: 35,
                                          width: 100,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.all(5),
                                                  alignment: Alignment.center,
                                                  backgroundColor: Color(CustomColors.main),
                                                  shape:
                                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                              onPressed: () {
                                                Ip().resetIp();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Сбросить",
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700))),
                                        ),
                                        SizedBox(),
                                        SizedBox(
                                          height: 35,
                                          width: 100,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.all(5),
                                                  alignment: Alignment.center,
                                                  backgroundColor: Color(CustomColors.main),
                                                  shape:
                                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                              onPressed: () {
                                                if (newIp == null) {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext context) => AuthDenySheet(
                                                            type: "none",
                                                          ));
                                                } else {
                                                  Ip().setIp(newIp!);
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: const Text("Готово",
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700))),
                                        )
                                      ]));
                        },
                        child: Container(
                          height: 90,
                          width: 155,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(offset: Offset(0, 3), blurRadius: 5, spreadRadius: 1, color: Colors.black26)
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, left: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 85,
                                  child: Text(
                                    "Сменить IP модели",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        color: Color(CustomColors.main),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0, left: 5),
                                  child: Icon(Icons.tap_and_play_outlined, size: 40, color: Color(CustomColors.main)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                          height: 90, width: 155, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20))),
                    ],
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
