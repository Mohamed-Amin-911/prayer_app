import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isChecked = false;
  set setIsChecked(bool value) => _isChecked = value;
  bool get getIsChecked => _isChecked;
}
