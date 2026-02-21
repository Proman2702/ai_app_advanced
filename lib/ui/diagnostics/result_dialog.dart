import 'package:ai_app/etc/colors/colors.dart';
import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  final String info;
  const ResultDialog({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        info,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          height: 30,
          width: 120,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(CustomColors.main),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () => Navigator.pop(context),
              child: const Text("Закрыть", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
        ),
      ],
    );
  }
}
