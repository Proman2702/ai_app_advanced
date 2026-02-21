import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:flutter/material.dart';

class TasksMenuTile extends StatelessWidget {
  const TasksMenuTile({super.key, required this.dbGetter, required this.defectType});

  final GetValues? dbGetter;
  final List defectType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/tasks/levels', arguments: defectType);
          },
          child: Container(
              width: 330,
              height: 80,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 15, right: 10),
              decoration: BoxDecoration(
                  gradient: dbGetter?.getUser()?.defects == null
                      ? GreyTile()
                      : dbGetter!.getUser()!.defects[defectType[0]] == 2
                          ? TileGrad1()
                          : GreyTile(),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(spreadRadius: 1, offset: Offset(0, 3), blurRadius: 2, color: Colors.black26)
                  ]),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${defectType[1]}',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'nunito'))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Задание ${dbGetter?.getUser()?.currentLevel[defectType[0]] ?? 0}/6',
                          style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600))
                    ],
                  )
                ],
              )),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 330,
          child: Text(
            dbGetter?.getUser()?.defects == null
                ? 'Загрузка...'
                : dbGetter!.getUser()!.defects[defectType[0]] == 1
                    ? 'Не рекомендуется диагностикой'
                    : dbGetter!.getUser()!.defects[defectType[0]] == 2
                        ? 'Рекомендуется'
                        : 'Диагностика не пройдена',
            style: const TextStyle(color: Colors.white30, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
