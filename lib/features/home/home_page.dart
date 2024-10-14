// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/repositories/database/get_values.dart';


import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/models/user.dart';
import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<dynamic>? users;
  GetValues? dbGetter;
  

  asyncGetter() async {

    await database.getUsers().listen((snapshot) {
        List<dynamic> users_tmp = snapshot.docs;
        dbGetter = GetValues(subject: "username", user: user!, users: users_tmp);
        setState(() {
          users = users_tmp;
        });
      }
      );
    
    
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();

    asyncGetter();
  
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
              child: IconButton(onPressed: null, icon: Icon(Icons.menu, color: Color(CustomColors.main), size: 30)),
            ),
            title: Center(
                child: Text(
                  dbGetter?.getUser()?.username ?? '<Загрузка...>', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(CustomColors.main))
                  )
            
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        Navigator.of(context).pushNamed('/settings', arguments: user);
                      },
                      icon: Icon(Icons.settings, color: Color(CustomColors.main), size: 30)),
                  SizedBox(width: 10)
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10,),
                  InformationField(),
                  SizedBox(height: 10,),
            
                  Container(height: 480, width: 400, decoration: BoxDecoration(color: Colors.white, 
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
                  child: 
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Center(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Меню", style: TextStyle(color: Color(CustomColors.main), fontSize: 25, fontWeight: FontWeight.w700)),
                              Container(width: 335, height: 1, color: Colors.black26,)
                            ],
                          ),),

                          SizedBox(height: 25),
                          Center(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(height: 85, width: 340, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), gradient: TileGrad1(), 
                                boxShadow: [BoxShadow(spreadRadius: 2, offset: Offset(0, 3), blurRadius: 4, color: Colors.black26)]),),
                              )

                          ],),),
                          SizedBox(height: 25),
                          Center(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(height: 85, width: 340, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), gradient: TileGrad2(), 
                                boxShadow: [BoxShadow(spreadRadius: 2, offset: Offset(0, 3), blurRadius: 4, color: Colors.black26)]),),
                              )

                          ],),),
                          SizedBox(height: 25),
                          Center(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(height: 85, width: 340, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), gradient: TileGrad3(), 
                                boxShadow: [BoxShadow(spreadRadius: 2, offset: Offset(0, 3), blurRadius: 4, color: Colors.black26)]),),
                              )

                          ],),),
                                  
                        ],
                      ),
                    ),)
            
                  
                ],
              ),
          ),
        ),
        ),
    );
  }
}

class InformationField extends StatefulWidget {
  const InformationField({super.key});

  @override
  State<InformationField> createState() => _InformationFieldState();
}

class _InformationFieldState extends State<InformationField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 400,
      color: Colors.transparent,
    );
  }
}
