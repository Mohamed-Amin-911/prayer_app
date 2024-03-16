import 'package:flutter/material.dart';

class Sizeconfig {
  static const double designWidth = 375;
  static const double designHeight = 733;
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double verticalBlock;
  static late double screenHeight;
  static late double horizontalBlock;
  static late double statusBarHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    statusBarHeight = _mediaQueryData.padding.top;
    horizontalBlock = (screenWidth) / designWidth;
    verticalBlock = (screenHeight - statusBarHeight) / designHeight;
  }
}
