// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ai_app/etc/colors/colors.dart';
import 'package:flutter/material.dart';

class HelpDialog extends StatelessWidget {
  HelpDialog({super.key, required this.defect});

  final int defect;

  List<Widget> choose_info() {
    switch (defect) {
      case 1:
        return help_1;
      case 2:
        return help_2;
      case 3:
        return help_3;
    }
    return [];
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choose_info(),
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
                child: const Text("Закрыть",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700))),
          ),
        ]);
  }

  final List<Widget> help_1 = [
    RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
            fontSize: 16.0, color: Colors.black87, height: 1.1, fontFamily: 'nunito', letterSpacing: 0.5),
        children: <TextSpan>[
          TextSpan(text: 'Упражнение №1 "Пулемет":\n', style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
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
          TextSpan(text: 'Упражнение №2 "Кукушка":\n', style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
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
          TextSpan(text: 'Упражнение №3 "Маляр":\n', style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
          TextSpan(
              text:
                  'Рот в этот раз приоткрыт. Язык будет вашей кистью, им надо «покрасить» небо, зубы, щеки. Делайте широкие «мазки».'),
        ],
      ),
    ),
    SizedBox(height: 15),
    Container(width: 300, height: 1, color: Colors.black12),
  ];
  final List<Widget> help_2 = [
    RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
            fontSize: 16.0, color: Colors.black87, height: 1.1, fontFamily: 'nunito', letterSpacing: 0.5),
        children: <TextSpan>[
          TextSpan(text: 'Упражнение №1 "Катушка":\n', style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
          TextSpan(
              text:
                  'Рот открыт, кончик языка упирается в нижние зубы, боковые края прижаты к верхним коренным зубам. Широкий язык выталкивается вперед и упирается вглубь рта.'),
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
          TextSpan(text: 'Упражнение №2 "Чашечка":\n', style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
          TextSpan(
              text:
                  'Рот широко открыть. Широкий язык поднять кверху. Подтянуться боковыми краями и кончиком языка к верхним зубам, но не касаться их.'),
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
          TextSpan(text: 'Упражнение №3 "Горка":\n', style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
          TextSpan(text: 'Улыбнуться, показать зубы, кончик языка поднять за нижние зубы и выдохнуть воздух.'),
        ],
      ),
    ),
    SizedBox(height: 15),
    Container(width: 300, height: 1, color: Colors.black12),
  ];

  final List<Widget> help_3 = [
    RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
            fontSize: 16.0, color: Colors.black87, height: 1.1, fontFamily: 'nunito', letterSpacing: 0.5),
        children: <TextSpan>[
          TextSpan(
              text: 'Упражнение №1 "Для языка":\n', style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
          TextSpan(
              text:
                  'Надуть щеки и покрутить языком, словно он обходит зубы кругом. Питмично высовывать язык и быстро втягивать его обратно. Уложить язык под верхнюю и нижнюю губы или скрутить его в трубочку.'),
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
          TextSpan(text: 'Упражнение №2 "Мяч":\n', style: const TextStyle(fontWeight: FontWeight.bold, height: 3)),
          TextSpan(
              text:
                  'Представить мяч, «взять» его в руки и «ударить» об пол. При этом считать каждый удар до 10-ти. Потом опять считать, но на этот раз подбрасывать мячик вверх. Счет ведется на выдохе. Когда «мяч» ударяется о пол, делать голос ниже, когда взлетает вверх — выше.'),
        ],
      ),
    ),
    SizedBox(height: 15),
    Container(width: 300, height: 1, color: Colors.black12),
  ];
}
