import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:flutter/material.dart';

class LevelTile extends StatelessWidget {
  const LevelTile({super.key, required this.dbGetter, required this.defectType, required this.level});

  final GetValues? dbGetter;
  final List defectType;
  final int level;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dbGetter?.getUser()?.currentLevel == null
          ? () {}
          : dbGetter!.getUser()!.currentLevel['${defectType[0]}'] >= level
              ? () async {
                  Navigator.of(context).pushNamed('/tasks/levels/level', arguments: [
                    int.parse(defectType[0]),
                    level == 0 ? 1 : level,
                    dbGetter!.getUser()!.currentLevel['${defectType[0]}'] == level ? 0 : 1
                  ]);

                  // Проверка если текущий уровень больше этого
                }
              : () {},
      child: Container(
        height: 105,
        width: 150,
        decoration: BoxDecoration(
            color: dbGetter?.getUser()?.currentLevel == null
                ? Colors.grey
                : dbGetter!.getUser()!.currentLevel['${defectType[0]}'] >= level
                    ? Colors.white
                    : Colors.grey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Уровень ${level == 0 ? 1 : level}',
                style: TextStyle(
                    color: Color(CustomColors.main), fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'nunito')),
            const SizedBox(height: 10),
            Icon(
              dbGetter?.getUser()?.currentLevel == null
                  ? Icons.lock
                  : dbGetter!.getUser()!.currentLevel['${defectType[0]}'] == level
                      ? Icons.timer_outlined
                      : dbGetter!.getUser()!.currentLevel['${defectType[0]}'] > level
                          ? Icons.check
                          : Icons.lock,
              color: Color(CustomColors.main),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
