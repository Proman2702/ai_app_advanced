// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ai_app/etc/colors/colors.dart';
import 'package:flutter/material.dart';

class HelpDialog1 extends StatelessWidget {
  const HelpDialog1({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.only(top: 15, left: 15, right: 15),
        contentPadding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        title: Center(
            child: Column(
          children: [
            Text(
              "Упражнения, которые помогут исправить дефект",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(width: 300, height: 1, color: Colors.black12),
          ],
        )),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: const TextStyle(
                      fontSize: 16.0, color: Colors.black87, height: 1.1, fontFamily: 'nunito', letterSpacing: 0.5),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Упражнение №1 "Пулемет":\n',
                        style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
                    TextSpan(
                        text:
                            'Ставим кончик языка на бугорки верхнего неба за зубами и произносим звук Т или Д. Сначала медленно, «одиночными выстрелами». Потом быстрее, соединяем их в группы.'),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: const TextStyle(
                      fontSize: 16.0, color: Colors.black87, height: 1.1, fontFamily: 'nunito', letterSpacing: 0.5),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Упражнение №2 "Кукушка":\n',
                        style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
                    TextSpan(
                        text:
                            'Откройте широко рот. Высовывайте язык и дотрагивайтесь кончиком до верхней губы, а потом убирайте его за верхние зубы.'),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: const TextStyle(
                      fontSize: 16.0, color: Colors.black87, height: 1.1, fontFamily: 'nunito', letterSpacing: 0.5),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Упражнение №3 "Маляр":\n',
                        style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
                    TextSpan(
                        text:
                            'Рот в этот раз приоткрыт. Язык будет вашей кистью, им надо «покрасить» небо, зубы, щеки. Делайте широкие «мазки».'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(width: 300, height: 1, color: Colors.black12),
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
                  Navigator.pop(context);
                },
                child: const Text("Обратно",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700))),
          ),
        ]);
  }
}

class HelpDialog2 extends StatelessWidget {
  const HelpDialog2({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.only(top: 15, left: 15, right: 15),
        contentPadding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        title: Center(
            child: Column(
          children: [
            Text(
              "Упражнения, которые помогут исправить дефект",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(width: 300, height: 1, color: Colors.black12),
          ],
        )),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: const TextStyle(
                      fontSize: 16.0, color: Colors.black87, height: 1.1, fontFamily: 'nunito', letterSpacing: 0.5),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Упражнение №1 "г":\n', style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
                    TextSpan(text: 'бурда бурда бурда бурда бурда бурда бурда бурда бурда бурда'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(width: 300, height: 1, color: Colors.black12),
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
                  Navigator.pop(context);
                },
                child: const Text("Обратно",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700))),
          ),
        ]);
  }
}
