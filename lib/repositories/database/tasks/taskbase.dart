import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class Tasks {
  final int? _defectType;
  final int? _level;
  List? _words;

  /// Private constructor
  Tasks._create({int? defectType, int? level})
      : _level = level,
        _defectType = defectType;

  Future<void> _loadAsset() async {
    String str = await rootBundle.loadString('assets/defects/${_defectType!}/${_level!}.txt');
    _words = str.split('\n');
  }

  String getRandomWord() {
    String word = _words![math.Random().nextInt(_words!.length)];
    return word;
  }

  /// Public factory
  static Future<Tasks> create(int type, int level) async {
    log('<tasks> called');

    // Call the private constructor
    var component = Tasks._create(defectType: type, level: level);

    await component._loadAsset();

    log('<tasks> called');
    return component;
  }
}
