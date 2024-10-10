// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:developer';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.logout, color: Colors.white)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.info, color: Colors.white)),
        ],
      ),
      body: Center(
        child: StreamBuilder(
            stream: database.getUsers(),
            builder: (context, snapshot) {
              List users = snapshot.data?.docs ?? [];

              for (var i in users) {
                if (i.id == user!.email) {
                  return Text("Добро пожаловать, ${i.data().username}");
                }
              }
              return Text("Добро пожаловать, null");
            }),
      ),
    );
  }
}
