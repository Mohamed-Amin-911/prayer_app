// import 'package:flutter/material.dart';
// import 'package:prayer_app/config/size_config.dart';
// import 'package:prayer_app/provider/prayer_provider.dart';
// import 'package:provider/provider.dart';

// class PrayerCard extends StatefulWidget {
//   const PrayerCard({
//     super.key,
//     required this.prayer,
//     required this.isPrayed,
//     required this.prayerTime,
//   });
//   final String prayer;
//   final bool isPrayed;
//   final String prayerTime;

//   @override
//   State<PrayerCard> createState() => _PrayerCardState();
// }

// class _PrayerCardState extends State<PrayerCard> {
//   bool isFajr = false;
//   bool isDhuhr = false;
//   bool isAsr = false;
//   bool isMaghrib = false;
//   bool isIsha = false;
//   bool isDoha = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     isFajr =
//         Provider.of<PrayerProvider>(context, listen: false).getIsFajrPrayed;
//     isDhuhr =
//         Provider.of<PrayerProvider>(context, listen: false).getIsDuhurPrayed;
//     isAsr = Provider.of<PrayerProvider>(context, listen: false).getIsAsrPrayed;
//     isMaghrib =
//         Provider.of<PrayerProvider>(context, listen: false).getIsMaghribPrayed;
//     isIsha =
//         Provider.of<PrayerProvider>(context, listen: false).getIsIshaPrayed;
//     isDoha =
//         Provider.of<PrayerProvider>(context, listen: false).getIsDohaPrayed;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "  ${widget.prayer} Prayer",
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 15),
//                 ),
//                 SizedBox(height: 13 * Sizeconfig.verticalBlock),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.access_time_rounded,
//                       color: Color(0xffBABABA),
//                     ),
//                     SizedBox(width: 15 * Sizeconfig.horizontalBlock),
//                     Text(
//                       widget.prayerTime,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                           color: Color(0xff636363)),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             const Spacer(),
//             IconButton(
//                 onPressed: () {
//                   if (widget.prayer == "Fajr") {
//                     Provider.of<PrayerProvider>(context, listen: false)
//                             .setIsFajrPrayed =
//                         !Provider.of<PrayerProvider>(context, listen: false)
//                             .getIsFajrPrayed;
//                   } else if (widget.prayer == "Duhur") {
//                     Provider.of<PrayerProvider>(context, listen: false)
//                             .setIsDuhurPrayed =
//                         !Provider.of<PrayerProvider>(context, listen: false)
//                             .getIsDuhurPrayed;
//                   } else if (widget.prayer == "Asr") {
//                     Provider.of<PrayerProvider>(context, listen: false)
//                             .setIsAsrPrayed =
//                         !Provider.of<PrayerProvider>(context, listen: false)
//                             .getIsAsrPrayed;
//                   } else if (widget.prayer == "Maghrib") {
//                     Provider.of<PrayerProvider>(context, listen: false)
//                             .setIsMaghribPrayed =
//                         !Provider.of<PrayerProvider>(context, listen: false)
//                             .getIsMaghribPrayed;
//                   } else if (widget.prayer == "Isha’") {
//                     Provider.of<PrayerProvider>(context, listen: false)
//                             .setIsIshaPrayed =
//                         !Provider.of<PrayerProvider>(context, listen: false)
//                             .getIsIshaPrayed;
//                   } else if (widget.prayer == "Doha") {
//                     Provider.of<PrayerProvider>(context, listen: false)
//                             .setIsDohaPrayed =
//                         !Provider.of<PrayerProvider>(context, listen: false)
//                             .getIsDohaPrayed;
//                   }
//                   print(Provider.of<PrayerProvider>(context, listen: false)
//                       .getIsFajrPrayed);
//                 },
//                 icon: isFajr?
//                     ? const Icon(
//                         Icons.check_circle_rounded,
//                         color: Color(0xff52BF95),
//                         size: 40,
//                       )
//                     : const Icon(
//                         Icons.check_circle_outline_rounded,
//                         color: Color(0xff636363),
//                         size: 40,
//                       ))
//           ],
//         ),
//         SizedBox(height: 10 * Sizeconfig.verticalBlock),
//         Container(
//           height: 1,
//           color: const Color(0xff636363),
//         ),
//       ],
//     );
//   }
// }
