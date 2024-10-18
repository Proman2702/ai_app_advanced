// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:flutter/material.dart';

class LevelsMenu extends StatefulWidget {
  const LevelsMenu({super.key});

  @override
  State<LevelsMenu> createState() => _LevelsMenuState();
}

class _LevelsMenuState extends State<LevelsMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,

        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(backgroundColor: Colors.transparent,
          

          leadingWidth: 65,
          
          leading: Padding(
            padding: EdgeInsets.only(left: 15),
              child: Container(
                height: 50,
                width: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(CustomColors.main),
                      )),
                ),
          ),
          ),
        ),

        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              SizedBox(
                width: 320,
                child: Text('Курс по коррекции картавости', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),)),

              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      Container(
                        height: 105,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)]),
                      ),
                      Text('Тренировка звуков', style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 105,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)]),
                      ),
                      Text('Тренировка слогов', style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              )
            ],
          ),
        ),

      ),
    );
  }
}