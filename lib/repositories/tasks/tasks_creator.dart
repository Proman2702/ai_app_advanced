import 'dart:math';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/repositories/tasks/asset_guard.dart';
import 'package:flutter/services.dart';

class Tasks {
  final AssetBundle bundle;
  final Random _rnd = Random();

  Tasks(this.bundle);

  Future<Result> getWordsRandom(int type, int level) async {
    return AssetGuard.assetGuard(() async {
      final List<String> words = (await bundle.loadString("assets/defects/$type/$level.txt")).split("\n");
      return words[_rnd.nextInt(words.length)];
    });
  }
}
