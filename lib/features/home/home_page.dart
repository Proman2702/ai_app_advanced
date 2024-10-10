// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:developer';

import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = AuthService();
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
      body: Center(child: Text("Добро пожаловать, ${user!.email}!")),
    );
  }
}
