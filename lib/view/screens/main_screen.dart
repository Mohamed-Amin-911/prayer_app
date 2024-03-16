import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:prayer_app/config/size_config.dart';
import 'package:prayer_app/constants/text_style.dart';
import 'package:prayer_app/view/widgets/prayer_card.dart';
import 'package:shadow/shadow.dart';
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 77 * Sizeconfig.verticalBlock),
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
            child: Text(
              "Completion : 75%",
              style:
                  appStyle(fw: FontWeight.w600, size: 16, color: Colors.black),
            ),
          ),
          SizedBox(height: 19 * Sizeconfig.verticalBlock),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2500,
              percent: 0.8,
              barRadius: const Radius.circular(10),
              backgroundColor: const Color(0xffC4C4C4),
              progressColor: const Color(0xffF5AC1C),
            ),
          ),
          SizedBox(height: 25 * Sizeconfig.verticalBlock),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Expanded(
              child: Column(
                children: [
                  const PrayerCard(
                    isPrayed: false,
                    prayer: "Fajr",
                    prayerTime: "04:03",
                  ),
                  SizedBox(height: 15 * Sizeconfig.verticalBlock),
                  const PrayerCard(
                    isPrayed: false,
                    prayer: "Dzuhr",
                    prayerTime: "04:03",
                  ),
                  SizedBox(height: 15 * Sizeconfig.verticalBlock),
                  const PrayerCard(
                    isPrayed: false,
                    prayer: "Asr",
                    prayerTime: "04:03",
                  ),
                  SizedBox(height: 15 * Sizeconfig.verticalBlock),
                  const PrayerCard(
                    isPrayed: false,
                    prayer: "Maghrib",
                    prayerTime: "04:03",
                  ),
                  SizedBox(height: 15 * Sizeconfig.verticalBlock),
                  const PrayerCard(
                    isPrayed: false,
                    prayer: "Isha’",
                    prayerTime: "04:03",
                  ),
                  SizedBox(height: 15 * Sizeconfig.verticalBlock),
                  const PrayerCard(
                    isPrayed: false,
                    prayer: "Doha",
                    prayerTime: "04:03",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
