import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:prayer_app/config/size_config.dart';
import 'package:prayer_app/constants/text_style.dart';
import 'package:prayer_app/model/user_secure_storage_class.dart';
import 'package:prayer_app/provider/prayer_provider.dart';
import 'package:prayer_app/view/screens/sign_up_screen.dart';
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
                child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "  Fajr Prayer",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            SizedBox(height: 13 * Sizeconfig.verticalBlock),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: Color(0xffBABABA),
                                ),
                                SizedBox(
                                    width: 15 * Sizeconfig.horizontalBlock),
                                FutureBuilder(
                                  future: Provider.of<PrayerProvider>(context)
                                      .getPrayer(),
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data!.fajrTime,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0xff636363)),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        FutureBuilder(
                          future: SecureStorage.readData("Fajr"),
                          builder: (context, snapshot) {
                            return IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsFajrPrayed ==
                                        false) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsFajrPrayed = true;
                                      Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion =
                                          Provider.of<PrayerProvider>(context,
                                                      listen: false)
                                                  .completion +
                                              (1 / 6);
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgress();
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgressForSlider();
                                    } else if (Provider.of<PrayerProvider>(
                                            context,
                                            listen: false)
                                        .getIsFajrPrayed) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsFajrPrayed = false;
                                      if (Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion !=
                                          0) {
                                        Provider.of<PrayerProvider>(context,
                                                    listen: false)
                                                .completion =
                                            Provider.of<PrayerProvider>(context,
                                                        listen: false)
                                                    .completion -
                                                (1 / 6);
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgress();
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgressForSlider();
                                      }
                                    }

                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsFajrPrayed ==
                                        false) {
                                      SecureStorage.writeData(
                                          "Fajr", "isFPrayed");
                                    } else if (Provider.of<PrayerProvider>(
                                                context,
                                                listen: false)
                                            .getIsFajrPrayed ==
                                        true) {
                                      SecureStorage.writeData(
                                          "Fajr", "isFNotPrayed");
                                    }

                                    if (snapshot.data == "isFNotPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsFajrPrayed = true;
                                    } else if (snapshot.data == "isFPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsFajrPrayed = false;
                                    }
                                  });
                                },
                                icon: snapshot.data == "isFNotPrayed"
                                    ? const Icon(
                                        Icons.check_circle_rounded,
                                        color: Color(0xff52BF95),
                                        size: 40,
                                      )
                                    : const Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Color(0xff636363),
                                        size: 40,
                                      ));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 10 * Sizeconfig.verticalBlock),
                    Container(
                      height: 1,
                      color: const Color(0xff636363),
                    ),
                  ],
                ),
                SizedBox(height: 15 * Sizeconfig.verticalBlock),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "  Duhur Prayer",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            SizedBox(height: 13 * Sizeconfig.verticalBlock),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: Color(0xffBABABA),
                                ),
                                SizedBox(
                                    width: 15 * Sizeconfig.horizontalBlock),
                                FutureBuilder(
                                  future: Provider.of<PrayerProvider>(context)
                                      .getPrayer(),
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data!.duhuhrTime,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0xff636363)),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        FutureBuilder(
                          future: SecureStorage.readData("Duhur"),
                          builder: (context, snapshot) {
                            return IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsDuhurPrayed ==
                                        false) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsDuhurPrayed = true;
                                      Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion =
                                          Provider.of<PrayerProvider>(context,
                                                      listen: false)
                                                  .completion +
                                              (1 / 6);
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgress();
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgressForSlider();
                                    } else if (Provider.of<PrayerProvider>(
                                            context,
                                            listen: false)
                                        .getIsDuhurPrayed) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsDuhurPrayed = false;
                                      if (Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion !=
                                          0) {
                                        Provider.of<PrayerProvider>(context,
                                                    listen: false)
                                                .completion =
                                            Provider.of<PrayerProvider>(context,
                                                        listen: false)
                                                    .completion -
                                                (1 / 6);
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgress();
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgressForSlider();
                                      }
                                    }
                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsDuhurPrayed ==
                                        false) {
                                      SecureStorage.writeData(
                                          "Duhur", "isDPrayed");
                                    } else if (Provider.of<PrayerProvider>(
                                                context,
                                                listen: false)
                                            .getIsDuhurPrayed ==
                                        true) {
                                      SecureStorage.writeData(
                                          "Duhur", "isDNotPrayed");
                                    }
                                    if (snapshot.data == "isDNotPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsDuhurPrayed = true;
                                    } else if (snapshot.data == "isDPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsDuhurPrayed = false;
                                    }
                                    print(snapshot.data);
                                  });
                                },
                                icon: snapshot.data == "isDNotPrayed"
                                    ? const Icon(
                                        Icons.check_circle_rounded,
                                        color: Color(0xff52BF95),
                                        size: 40,
                                      )
                                    : const Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Color(0xff636363),
                                        size: 40,
                                      ));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 10 * Sizeconfig.verticalBlock),
                    Container(
                      height: 1,
                      color: const Color(0xff636363),
                    ),
                  ],
                ),
                SizedBox(height: 15 * Sizeconfig.verticalBlock),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "  Asr Prayer",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            SizedBox(height: 13 * Sizeconfig.verticalBlock),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: Color(0xffBABABA),
                                ),
                                SizedBox(
                                    width: 15 * Sizeconfig.horizontalBlock),
                                FutureBuilder(
                                  future: Provider.of<PrayerProvider>(context)
                                      .getPrayer(),
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data!.asrTime,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0xff636363)),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        FutureBuilder(
                          future: SecureStorage.readData("Asr"),
                          builder: (context, snapshot) {
                            return IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsAsrPrayed ==
                                        false) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsAsrPrayed = true;
                                      Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion =
                                          Provider.of<PrayerProvider>(context,
                                                      listen: false)
                                                  .completion +
                                              (1 / 6);
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgress();
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgressForSlider();
                                    } else if (Provider.of<PrayerProvider>(
                                            context,
                                            listen: false)
                                        .getIsAsrPrayed) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsAsrPrayed = false;
                                      if (Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion !=
                                          0) {
                                        Provider.of<PrayerProvider>(context,
                                                    listen: false)
                                                .completion =
                                            Provider.of<PrayerProvider>(context,
                                                        listen: false)
                                                    .completion -
                                                (1 / 6);
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgress();
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgressForSlider();
                                      }
                                    }

                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsAsrPrayed ==
                                        false) {
                                      SecureStorage.writeData(
                                          "Asr", "isAPrayed");
                                    } else if (Provider.of<PrayerProvider>(
                                                context,
                                                listen: false)
                                            .getIsAsrPrayed ==
                                        true) {
                                      SecureStorage.writeData(
                                          "Asr", "isANotPrayed");
                                    }
                                    if (snapshot.data == "isAPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsAsrPrayed = true;
                                    } else if (snapshot.data ==
                                        "isANotPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsAsrPrayed = false;
                                    }
                                    print(snapshot.data);
                                  });
                                },
                                icon: snapshot.data == "isANotPrayed"
                                    ? const Icon(
                                        Icons.check_circle_rounded,
                                        color: Color(0xff52BF95),
                                        size: 40,
                                      )
                                    : const Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Color(0xff636363),
                                        size: 40,
                                      ));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 10 * Sizeconfig.verticalBlock),
                    Container(
                      height: 1,
                      color: const Color(0xff636363),
                    ),
                  ],
                ),
                SizedBox(height: 15 * Sizeconfig.verticalBlock),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "  Maghrib Prayer",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            SizedBox(height: 13 * Sizeconfig.verticalBlock),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: Color(0xffBABABA),
                                ),
                                SizedBox(
                                    width: 15 * Sizeconfig.horizontalBlock),
                                FutureBuilder(
                                  future: Provider.of<PrayerProvider>(context)
                                      .getPrayer(),
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data!.maghribTime,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0xff636363)),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        FutureBuilder(
                          future: SecureStorage.readData("Maghrib"),
                          builder: (context, snapshot) {
                            return IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsMaghribPrayed ==
                                        false) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsMaghribPrayed = true;
                                      Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion =
                                          Provider.of<PrayerProvider>(context,
                                                      listen: false)
                                                  .completion +
                                              (1 / 6);
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgress();
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgressForSlider();
                                    } else if (Provider.of<PrayerProvider>(
                                            context,
                                            listen: false)
                                        .getIsMaghribPrayed) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsMaghribPrayed = false;
                                      if (Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion !=
                                          0) {
                                        Provider.of<PrayerProvider>(context,
                                                    listen: false)
                                                .completion =
                                            Provider.of<PrayerProvider>(context,
                                                        listen: false)
                                                    .completion -
                                                (1 / 6);
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgress();
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgressForSlider();
                                      }
                                    }
                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsMaghribPrayed ==
                                        false) {
                                      SecureStorage.writeData(
                                          "Maghrib", "isMPrayed");
                                    } else if (Provider.of<PrayerProvider>(
                                                context,
                                                listen: false)
                                            .getIsMaghribPrayed ==
                                        true) {
                                      SecureStorage.writeData(
                                          "Maghrib", "isMNotPrayed");
                                    }
                                    if (snapshot.data == "isMPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsMaghribPrayed = true;
                                    } else if (snapshot.data ==
                                        "isMNotPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsMaghribPrayed = false;
                                    }
                                    print(snapshot.data);
                                  });
                                },
                                icon: snapshot.data == "isMNotPrayed"
                                    ? const Icon(
                                        Icons.check_circle_rounded,
                                        color: Color(0xff52BF95),
                                        size: 40,
                                      )
                                    : const Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Color(0xff636363),
                                        size: 40,
                                      ));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 10 * Sizeconfig.verticalBlock),
                    Container(
                      height: 1,
                      color: const Color(0xff636363),
                    ),
                  ],
                ),
                SizedBox(height: 15 * Sizeconfig.verticalBlock),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "  Isha' Prayer",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            SizedBox(height: 13 * Sizeconfig.verticalBlock),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: Color(0xffBABABA),
                                ),
                                SizedBox(
                                    width: 15 * Sizeconfig.horizontalBlock),
                                FutureBuilder(
                                  future: Provider.of<PrayerProvider>(context)
                                      .getPrayer(),
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data!.ishaTime,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0xff636363)),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        FutureBuilder(
                          future: SecureStorage.readData("Isha"),
                          builder: (context, snapshot) {
                            return IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsIshaPrayed ==
                                        false) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsIshaPrayed = true;
                                      Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion =
                                          Provider.of<PrayerProvider>(context,
                                                      listen: false)
                                                  .completion +
                                              (1 / 6);
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgress();
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgressForSlider();
                                    } else if (Provider.of<PrayerProvider>(
                                            context,
                                            listen: false)
                                        .getIsIshaPrayed) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsIshaPrayed = false;
                                      if (Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion !=
                                          0) {
                                        Provider.of<PrayerProvider>(context,
                                                    listen: false)
                                                .completion =
                                            Provider.of<PrayerProvider>(context,
                                                        listen: false)
                                                    .completion -
                                                (1 / 6);
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgress();
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgressForSlider();
                                      }
                                    }
                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsIshaPrayed ==
                                        false) {
                                      SecureStorage.writeData(
                                          "Isha", "isIPrayed");
                                    } else if (Provider.of<PrayerProvider>(
                                                context,
                                                listen: false)
                                            .getIsIshaPrayed ==
                                        true) {
                                      SecureStorage.writeData(
                                          "Isha", "isINotPrayed");
                                    }
                                    if (snapshot.data == "isIPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsIshaPrayed = true;
                                    } else if (snapshot.data ==
                                        "isINotPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsIshaPrayed = false;
                                    }
                                    print(snapshot.data);
                                  });
                                },
                                icon: snapshot.data == "isINotPrayed"
                                    ? const Icon(
                                        Icons.check_circle_rounded,
                                        color: Color(0xff52BF95),
                                        size: 40,
                                      )
                                    : const Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Color(0xff636363),
                                        size: 40,
                                      ));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 10 * Sizeconfig.verticalBlock),
                    Container(
                      height: 1,
                      color: const Color(0xff636363),
                    ),
                  ],
                ),
                SizedBox(height: 15 * Sizeconfig.verticalBlock),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "  Doha Prayer",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            SizedBox(height: 13 * Sizeconfig.verticalBlock),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: Color(0xffBABABA),
                                ),
                                SizedBox(
                                    width: 15 * Sizeconfig.horizontalBlock),
                                FutureBuilder(
                                  future: Provider.of<PrayerProvider>(context)
                                      .getPrayer(),
                                  builder: (context, snapshot) {
                                    return const Text(
                                      "--:--",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0xff636363)),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        FutureBuilder(
                          future: SecureStorage.readData("Doha"),
                          builder: (context, snapshot) {
                            return IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsDohaPrayed ==
                                        false) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsDohaPrayed = true;
                                      Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion =
                                          Provider.of<PrayerProvider>(context,
                                                      listen: false)
                                                  .completion +
                                              (1 / 6);
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgress();
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .saveProgressForSlider();
                                    } else if (Provider.of<PrayerProvider>(
                                            context,
                                            listen: false)
                                        .getIsDohaPrayed) {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsDohaPrayed = false;
                                      if (Provider.of<PrayerProvider>(context,
                                                  listen: false)
                                              .completion !=
                                          0) {
                                        Provider.of<PrayerProvider>(context,
                                                    listen: false)
                                                .completion =
                                            Provider.of<PrayerProvider>(context,
                                                        listen: false)
                                                    .completion -
                                                (1 / 6);
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgress();
                                        Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .saveProgressForSlider();
                                      }
                                    }

                                    if (Provider.of<PrayerProvider>(context,
                                                listen: false)
                                            .getIsDohaPrayed ==
                                        false) {
                                      SecureStorage.writeData(
                                          "Doha", "isDoPrayed");
                                    } else if (Provider.of<PrayerProvider>(
                                                context,
                                                listen: false)
                                            .getIsDohaPrayed ==
                                        true) {
                                      SecureStorage.writeData(
                                          "Doha", "isDoNotPrayed");
                                    }
                                    if (snapshot.data == "isDoPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsDohaPrayed = true;
                                    } else if (snapshot.data ==
                                        "isDoNotPrayed") {
                                      Provider.of<PrayerProvider>(context,
                                              listen: false)
                                          .setIsDohaPrayed = false;
                                    }
                                    print(snapshot.data);
                                  });
                                },
                                icon: snapshot.data == "isDoNotPrayed"
                                    ? const Icon(
                                        Icons.check_circle_rounded,
                                        color: Color(0xff52BF95),
                                        size: 40,
                                      )
                                    : const Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Color(0xff636363),
                                        size: 40,
                                      ));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 10 * Sizeconfig.verticalBlock),
                  ],
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}
