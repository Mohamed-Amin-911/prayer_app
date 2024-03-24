import 'package:prayer_app/model/network_model.dart';
import 'package:prayer_app/model/prayer_class.dart';

class PrayerController {
  Future<Prayer> getPray() async {
    String url =
        "http://api.aladhan.com/v1/timingsByCity?city=Cairo&country=Egypt&method=8";
    Networking networking = Networking();
    final response = await networking.fetchData(url);
    Prayer prayer = Prayer(
      fajrTime: response["data"]["timings"]["Fajr"],
      duhuhrTime: response["data"]["timings"]["Dhuhr"],
      asrTime: response["data"]["timings"]["Asr"],
      maghribTime: response["data"]["timings"]["Maghrib"],
      ishaTime: response["data"]["timings"]["Isha"],
    );

    return prayer;
  }
}
