import 'package:flutter/material.dart';
import 'package:ai_app/etc/colors/colors.dart';

class AuthDenySheet extends StatelessWidget {
  const AuthDenySheet({super.key, required this.type});

  final String type;

  String handler() {
    if (type.compareTo("none") == 0) {
      return 'Не все данные заполнены';
    } else if (type.compareTo("length") == 0) {
      return 'Логин и пароль должны состоять не менее чем из 3 символов';
    }
    return 'Что-то пошло не так';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 200,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              alignment: Alignment.center,
              child: Text(
                handler(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              width: 110,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(CustomColors.mainLightX2)),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Закрыть",
                      style: TextStyle(color: Colors.white))),
            )
          ],
        ),
      ),
    );
  }
}
