import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/features/settings/confirmation_dialog.dart';
import 'package:ai_app/features/tasks/levels_page_tile.dart';
import 'package:ai_app/etc/models/user.dart';
import 'package:ai_app/repositories/database/firebase/firebase_users_database.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LevelsMenu extends StatefulWidget {
  const LevelsMenu({super.key});

  @override
  State<LevelsMenu> createState() => _LevelsMenuState();
}

class _LevelsMenuState extends State<LevelsMenu> {
  late List defectType;
  final database = DatabaseService();
  User? user;
  List<dynamic>? users;
  GetValues? dbGetter;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    database.getUsers().listen((snapshot) {
      List<dynamic> users = snapshot.docs;
      dbGetter = GetValues(user: user!, users: users);
      setState(() {});
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments; //NULL CHECK VALUE
    defectType = args as List;
    super.didChangeDependencies();
  }

  void clearCourse() async {
    if (dbGetter?.getUser()?.username != null) {
      CustomUser curUser = dbGetter!.getUser()!;
      var curCombo = curUser.currentCombo;
      var curLevel = curUser.currentLevel;
      var curLevels = curUser.lessonsPassed;
      var curCorrectLevels = curUser.lessonsCorrect;

      curLevel['${defectType[0]}'] = 0;
      curCombo['${defectType[0]}'] = 0;
      curLevels['${defectType[0]}'] = 0;
      curCorrectLevels['${defectType[0]}'] = 0;

      await database.updateUser(curUser.copyWith(
          current_combo: curCombo,
          current_level: curLevel,
          lessons_correct: curCorrectLevels,
          lessons_passed: curLevels));
      Navigator.of(context).pop();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 65,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
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
              const SizedBox(height: 40),
              SizedBox(
                  width: 320,
                  child: Text(
                    'Коррекция дефекта «${defectType[1]}»',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 1 уровень ВСЕГДА ОТКРЫТ
                      LevelTile(dbGetter: dbGetter, defectType: defectType, level: 0),
                      const Text(
                        'Тренировка звуков',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 2 уровень
                      LevelTile(dbGetter: dbGetter, defectType: defectType, level: 2),
                      const Text(
                        'Тренировка слогов',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 3 уровень
                      LevelTile(dbGetter: dbGetter, defectType: defectType, level: 3),
                      const Text(
                        'Тренировка слов\n',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 4 уровень
                      LevelTile(dbGetter: dbGetter, defectType: defectType, level: 4),
                      const Text(
                        textAlign: TextAlign.center,
                        'Тренировка \nсловосочетаний',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 5 уровень
                      LevelTile(dbGetter: dbGetter, defectType: defectType, level: 5),
                      const Text(
                        textAlign: TextAlign.center,
                        'Тренировка \nскороговорок',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 6 уровень
                      LevelTile(dbGetter: dbGetter, defectType: defectType, level: 6),
                      const Text(
                        'Контрольный\n',
                        style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              Container(
                height: 40,
                width: 210,
                decoration: BoxDecoration(
                    gradient: ButtonGrad(),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(spreadRadius: 1, offset: Offset(0, 2), blurRadius: 2, color: Colors.black26)
                    ]),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            ConfirmationDialog(info: "Вы уверены, что хотите очистить курс?", action: clearCourse));
                  },
                  child: const Text(
                    "Сбросить курс",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
