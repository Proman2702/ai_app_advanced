
import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/features/drawer.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(chosen: 4),
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(preferredSize: Size.fromHeight(65), child: AppBar(
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
                backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: Colors.black,
            leadingWidth: 60,
            leading: Padding(
              padding: const EdgeInsets.only(top: 5, left: 5),
              child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu, color: Color(CustomColors.main), size: 30))
            ),
            title: Center(
                child: Text(
              "О приложении",
              style: TextStyle(color: Color(CustomColors.main), fontWeight: FontWeight.w700, fontSize: 25),
            )),
            actions: [SizedBox(width: 50)],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
            
              children: 
            [
              SizedBox(height: 30,),
              SizedBox(width: 350, child: Text('AI App v1.0', style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold),)),
              SizedBox(height: 15,),
              Container(width: 350, height: 3, decoration: BoxDecoration(color: Colors.white24),),
              SizedBox(height: 5,),
              SizedBox(width: 350, child: Text('AI Т-Банк - саморазвитие', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold),)),
              SizedBox(height: 5,),
              SizedBox(width: 350, child: Text('Команда "Десептиконы"', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold),)),
              SizedBox(height: 15,),
              Container(width: 350, height: 3, decoration: BoxDecoration(color: Colors.white24),),
              SizedBox(height: 30,),
              Container(
                width: 350,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SizedBox(width: 350, child: Text('Описание', style: TextStyle(color: Color(CustomColors.main), fontSize: 28, fontWeight: FontWeight.w700, fontFamily: 'nunito', letterSpacing: 0.5),)),
                    SizedBox(height: 10,),
                    
                    SizedBox(width: 350, child: Text('Данное приложение представляет собой платформу для выявления, тренировки и последующего удаления различных речевых дефетов.', style: TextStyle(color: Color(CustomColors.main), fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'nunito', letterSpacing: 0.5, height: 1.2),)),
                    SizedBox(height: 15,),
                    SizedBox(width: 350, child: Text('В программу загружено 2 дефекта: "Картавость" и "фрикативное "Г".', style: TextStyle(color: Color(CustomColors.main), fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'nunito', letterSpacing: 0.5, height: 1.2),)),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: 350,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SizedBox(width: 350, child: Text('Краткое руководство', style: TextStyle(color: Color(CustomColors.main), fontSize: 28, fontWeight: FontWeight.w700, fontFamily: 'nunito', letterSpacing: 0.5),)),
                    SizedBox(height: 10,),
                    
                    SizedBox(width: 350, child: Text('...', style: TextStyle(color: Color(CustomColors.main), fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'nunito', letterSpacing: 0.5, height: 1.2),)),
                    SizedBox(height: 15,),
                    SizedBox(width: 350, child: Text('...', style: TextStyle(color: Color(CustomColors.main), fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'nunito', letterSpacing: 0.5, height: 1.2),)),
                  ],
                ),
              ),
            ],),
          ),
        ),
        )
    );
  }
}