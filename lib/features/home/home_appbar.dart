import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/repositories/database/get_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NamedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NamedAppBar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.dbGetter,
    required this.user,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final GetValues? dbGetter;
  final User? user;

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65.0),
      child: AppBar(
        shape: const RoundedRectangleBorder(
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
              icon: Icon(Icons.menu, color: Color(CustomColors.main), size: 30)),
        ),
        title: Center(
            child: Text(dbGetter?.getUser()?.username ?? 'Загрузка...',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(CustomColors.main)))),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamed('/settings', arguments: user);
                  },
                  icon: Icon(Icons.settings, color: Color(CustomColors.main), size: 30)),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
