import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:flutter/material.dart';

class DiagTile extends StatelessWidget {
  const DiagTile({super.key, required this.dbGetter, required this.defectType});

  final GetValues? dbGetter;
  final List defectType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/diagnostics/level', arguments: int.parse(defectType[0]));
      },
      child: Container(
        width: 330,
        height: 80,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 15, right: 5),
        decoration: BoxDecoration(
            gradient: TileGrad1(),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 185,
              height: 50,
              child: Text(
                'Дефект ${defectType[0]} - ${defectType[1]}',
                style: const TextStyle(height: 1.2, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                dbGetter?.getUser()?.defects == null
                    ? const CircularProgressIndicator()
                    : dbGetter!.getUser()!.defects[defectType[0]] == 1
                        ? const Icon(Icons.check, color: Colors.white)
                        : const Icon(Icons.cancel_outlined, color: Colors.white),
                SizedBox(
                  width: 120,
                  height: 20,
                  child: Text(
                    dbGetter?.getUser()?.defects == null
                        ? "Загрузка..."
                        : dbGetter!.getUser()!.defects[defectType[0]] == 0
                            ? "Обнаружено"
                            : dbGetter!.getUser()!.defects[defectType[0]] == 1
                                ? "Не обнаружено"
                                : "Еще не выполнено!",
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
