import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/etc/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class InformationField extends StatefulWidget {
  final CustomUser user;
  final List defectType;
  const InformationField({super.key, required this.user, required this.defectType});

  @override
  State<InformationField> createState() => _InformationFieldState();
}

class _InformationFieldState extends State<InformationField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Container(
        height: 300,
        width: 400,
        color: Colors.transparent,
        child: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(top: height / 3.7, left: width / 1.45),
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: Image.asset("images/hexagon.png",
                      scale: 1.2, opacity: const AlwaysStoppedAnimation(0.05), alignment: Alignment.center),
                )),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 300,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: TileGrad1(),
                            boxShadow: const [
                              BoxShadow(spreadRadius: 2, offset: Offset(0, 4), blurRadius: 4, color: Colors.black26)
                            ],
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
                        child: Text(
                          "${widget.defectType[1]}",
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 155,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const []),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ваш прогресс",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(CustomColors.main),
                                    fontSize: 17,
                                    fontFamily: 'nunito',
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 60,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(CustomColors.main), borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  widget.user.currentLevel['${widget.defectType[0]}'] != null
                                      ? widget.user.currentLevel['${widget.defectType[0]}'] == 7
                                          ? '100%'
                                          : '${widget.user.currentLevel['${widget.defectType[0]}']}%'
                                      : '?',
                                  style:
                                      const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      Container(
                        height: 100,
                        width: 155,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const []),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Текущая серия",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(CustomColors.main),
                                    fontSize: 17,
                                    fontFamily: 'nunito',
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 60,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(CustomColors.main), borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  widget.user.currentCombo['${widget.defectType[0]}'] != null
                                      ? '${widget.user.currentCombo['${widget.defectType[0]}']}'
                                      : '?', // !!! СОЕДИНИТЬ С БАЗОЙ ДАННЫХ
                                  style:
                                      const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Всего правильных заданий: ${widget.user.lessonsCorrect['${widget.defectType[0]}'] ?? "?"}",
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                      ), // !!! СОЕДИНИТЬ С БАЗОЙ ДАННЫХ
                      const SizedBox(height: 2),
                      SizedBox(
                        height: 15,
                        width: 320,
                        child: LinearProgressIndicator(
                          value: (((widget.user.lessonsPassed['${widget.defectType[0]}'] != null) &&
                                      ((widget.user.lessonsCorrect['${widget.defectType[0]}']) != null)) &&
                                  (widget.user.lessonsPassed['${widget.defectType[0]}'] != 0) &&
                                  (widget.user.lessonsCorrect['${widget.defectType[0]}'] != 0))
                              ? widget.user.lessonsCorrect['${widget.defectType[0]}'] /
                                  widget.user.lessonsPassed['${widget.defectType[0]}']
                              : 0.0,
                          borderRadius: BorderRadius.circular(10),
                          color: Color(CustomColors.bright),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 320,
                        child: Text(
                          textAlign: TextAlign.end,
                          "Всего заданий: ${widget.user.lessonsPassed['${widget.defectType[0]}'] ?? "?"}",
                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
