import 'package:flutter/material.dart';
import 'package:prayer_app/config/size_config.dart';

class PrayerCard extends StatelessWidget {
  const PrayerCard({
    super.key,
    required this.prayer,
    required this.isPrayed,
    required this.prayerTime,
  });
  final String prayer;
  final bool isPrayed;
  final String prayerTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  $prayer Prayer",
                  style: const TextStyle(
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
                    SizedBox(width: 15 * Sizeconfig.horizontalBlock),
                    Text(
                      prayerTime,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xff636363)),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Color(0xff636363),
                  size: 40,
                ))
          ],
        ),
        SizedBox(height: 10 * Sizeconfig.verticalBlock),
        Container(
          height: 1,
          color: const Color(0xff636363),
        ),
      ],
    );
  }
}
