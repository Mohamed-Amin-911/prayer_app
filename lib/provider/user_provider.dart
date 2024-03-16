import 'package:flutter/material.dart';
import 'package:prayer_app/model/user_class.dart';

class UserPRovider extends ChangeNotifier {
  List<User> users = [];

  void addUSer(User user) {
    users.add(user);
    notifyListeners();
  }

  User getUser() {
    return users[0];
  }
}
