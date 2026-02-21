import 'package:flutter/material.dart';
import 'package:ai_app/etc/colors/colors.dart';

class CustomGradients {
  static const backgroundGrad = LinearGradient(
    colors: CustomColors.backgroundGradColors,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    tileMode: TileMode.decal,
  );

  static const drawerGrad = LinearGradient(
    colors: CustomColors.drawerGradColors,
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    tileMode: TileMode.decal,
  );

  static const tileGrad = LinearGradient(
    colors: CustomColors.tileGradColors,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    tileMode: TileMode.decal,
  );
}
