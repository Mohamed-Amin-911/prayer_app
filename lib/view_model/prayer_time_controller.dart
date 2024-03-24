import 'package:prayer_app/model/network_model.dart';
import 'package:prayer_app/model/prayer_time_class.dart';

class PrayerController {
  Future<PrayerTime> getPray() async {
    String url =
        "http://api.aladhan.com/v1/timingsByCity?city=Cairo&country=Egypt&method=8";
    Networking networking = Networking();
    final response = await networking.fetchData(url);
    PrayerTime times = PrayerTime(
        fajr: response["data"]["timings"]["Fajr"],
        dhuhr: response["data"]["timings"]["Dhuhr"],
        asr: response["data"]["timings"]["Asr"],
        maghrib: response["data"]["timings"]["Maghrib"],
        isha: response["data"]["timings"]["Isha"]);

    return times;
  }
}
