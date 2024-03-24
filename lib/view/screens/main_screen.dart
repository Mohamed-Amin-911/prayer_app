import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:prayer_app/config/size_config.dart';
import 'package:prayer_app/constants/text_style.dart';
import 'package:prayer_app/model/shared_prefs_class.dart';
import 'package:prayer_app/model/user_secure_storage_class.dart';
import 'package:prayer_app/provider/prayer_provider.dart';
import 'package:prayer_app/view/screens/sign_up_screen.dart';
import 'package:prayer_app/view/widgets/prayer_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  final DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Sizeconfig().init(context);
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    Future<double> _getProgress() async {
      final SharedPreferences prefs = await _prefs;
      final double progress = prefs.getDouble('decimal')!;

      return progress;
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30 * Sizeconfig.verticalBlock),
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ));
                });
              },
              icon: const Icon(Icons.arrow_back)),
          SizedBox(height: 20 * Sizeconfig.verticalBlock),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 36),
            height: 1,
            color: const Color(0xff636363),
          ),
          SizedBox(height: 15 * Sizeconfig.verticalBlock),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: TableCalendar(
              calendarFormat: _calendarFormat,
              firstDay: DateTime.utc(2023, 3, 16),
              lastDay: DateTime.utc(2030, 3, 16),
              headerVisible: false,
              focusedDay: _focusedDay,
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                    color: Color(0xff52BF95), shape: BoxShape.circle),
              ),
            ),
          ),
          SizedBox(height: 25 * Sizeconfig.verticalBlock),
          Container(
            height: 18,
            color: const Color(0xffDCDCDC),
          ),
          SizedBox(height: 19 * Sizeconfig.verticalBlock),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: FutureBuilder(
                future: SecureStorage.readData("Progress"),
                builder: (context, snapshot) {
                  return Text(
                    "Completion : ${snapshot.data == "1" ? "0" : snapshot.data}%",
                    style: appStyle(
                        fw: FontWeight.w600, size: 16, color: Colors.black),
                  );
                },
              )),
          SizedBox(height: 19 * Sizeconfig.verticalBlock),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: FutureBuilder(
                future: SecureStorage.readData("ProgresSlider"),
                builder: (context, snapshot) {
                  return LinearProgressIndicator(
                    value: double.parse("${snapshot.data}"),
                  );
                },
              )),
          SizedBox(height: 25 * Sizeconfig.verticalBlock),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Flexible(
                child: FutureBuilder(
              future: Provider.of<PrayerProvider>(context).getPrayers(),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    FutureBuilder(
                      future: SharedPrefs.getBoolSharedPrefs("1"),
                      builder: (context, snapshot1) {
                        return PrayerCard(
                            index: 0,
                            title: "${snapshot.data?[0].title}",
                            time: "${snapshot.data?[0].time}",
                            isPressed: snapshot1.data ?? false);
                      },
                    ),
                    FutureBuilder(
                      future: SharedPrefs.getBoolSharedPrefs("2"),
                      builder: (context, snapshot2) {
                        return PrayerCard(
                            index: 1,
                            title: "${snapshot.data?[1].title}",
                            time: "${snapshot.data?[1].time}",
                            isPressed: snapshot2.data ?? false);
                      },
                    ),
                    FutureBuilder(
                      future: SharedPrefs.getBoolSharedPrefs("3"),
                      builder: (context, snapshot3) {
                        return PrayerCard(
                            index: 2,
                            title: "${snapshot.data?[2].title}",
                            time: "${snapshot.data?[2].time}",
                            isPressed: snapshot3.data ?? false);
                      },
                    ),
                    FutureBuilder(
                      future: SharedPrefs.getBoolSharedPrefs("4"),
                      builder: (context, snapshot4) {
                        return PrayerCard(
                            index: 3,
                            title: "${snapshot.data?[3].title}",
                            time: "${snapshot.data?[3].time}",
                            isPressed: snapshot4.data ?? false);
                      },
                    ),
                    FutureBuilder(
                      future: SharedPrefs.getBoolSharedPrefs("5"),
                      builder: (context, snapshot5) {
                        return PrayerCard(
                            index: 4,
                            title: "${snapshot.data?[4].title}",
                            time: "${snapshot.data?[4].time}",
                            isPressed: snapshot5.data ?? false);
                      },
                    ),
                    FutureBuilder(
                      future: SharedPrefs.getBoolSharedPrefs("6"),
                      builder: (context, snapshot6) {
                        return PrayerCard(
                            index: 5,
                            title: "${snapshot.data?[5].title}",
                            time: "${snapshot.data?[5].time}",
                            isPressed: snapshot6.data ?? false);
                      },
                    ),
                  ],
                );
              },
            )),
          )
        ],
      ),
    );
  }
}
