import 'package:flutter/material.dart';
import 'package:prayer_app/model/prayer_class.dart';
import 'package:prayer_app/model/prayer_time_class.dart';
import 'package:prayer_app/model/shared_prefs_class.dart';
import 'package:prayer_app/model/user_secure_storage_class.dart';
import 'package:prayer_app/view_model/prayer_time_controller.dart';

class PrayerProvider extends ChangeNotifier {
  double completion = 0;
  late PrayerTime prayerTime;

  Future<List<Prayer>> getPrayers() async {
    PrayerController prayer = PrayerController();
    prayerTime = await prayer.getPray();
    print(prayerTime.fajr);
    List<Prayer> prayers = [
      Prayer(title: "Fajr", time: prayerTime.fajr),
      Prayer(title: "Doha", time: "--:--"),
      Prayer(title: "Dhuhr", time: prayerTime.dhuhr),
      Prayer(title: "Asr ", time: prayerTime.asr),
      Prayer(title: "Maghrib", time: prayerTime.maghrib),
      Prayer(title: "Isha", time: prayerTime.isha)
    ];
    return prayers;
  }

  setCompletion(double val) {
    completion = completion + val;
    SharedPrefs.setCompSharedPrefs("p", completion);
  }
}
