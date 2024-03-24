import 'package:flutter/material.dart';
import 'package:prayer_app/model/prayer_class.dart';
import 'package:prayer_app/model/user_secure_storage_class.dart';
import 'package:prayer_app/view_model/prayer_time_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isFajrPrayed = false;
  set setIsFajrPrayed(bool value) => _isFajrPrayed = value;
  bool get getIsFajrPrayed => _isFajrPrayed;

  bool _isDuhurPrayed = false;
  set setIsDuhurPrayed(bool value) => _isDuhurPrayed = value;
  bool get getIsDuhurPrayed => _isDuhurPrayed;

  bool _isAsrPrayed = false;
  set setIsAsrPrayed(bool value) => _isAsrPrayed = value;
  bool get getIsAsrPrayed => _isAsrPrayed;

  bool _isMaghribPrayed = false;
  set setIsMaghribPrayed(bool value) => _isMaghribPrayed = value;
  bool get getIsMaghribPrayed => _isMaghribPrayed;

  bool _isIshaPrayed = false;
  set setIsIshaPrayed(bool value) => _isIshaPrayed = value;
  bool get getIsIshaPrayed => _isIshaPrayed;

  bool _isDohaPrayed = false;
  set setIsDohaPrayed(bool value) => _isDohaPrayed = value;
  bool get getIsDohaPrayed => _isDohaPrayed;

  double completion = 0;
  // set setCompletion(double val) => _completion + val;
  // get getCompletion => _completion;

  Future<Prayer> getPrayer() {
    PrayerController prayer = PrayerController();
    return prayer.getPray();
  }

  saveProgress() {
    SecureStorage.writeData("Progress", ((completion * 100).ceil()).toString());
  }

  saveProgressForSlider() {
    SecureStorage.writeData("ProgresSlider", (completion).toString());
  }
}
