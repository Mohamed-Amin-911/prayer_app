import 'package:flutter/material.dart';
import 'package:prayer_app/config/size_config.dart';
import 'package:prayer_app/model/shared_prefs_class.dart';
import 'package:prayer_app/provider/prayer_provider.dart';
import 'package:provider/provider.dart';

class PrayerCard extends StatefulWidget {
  const PrayerCard({
    super.key,
    required this.title,
    required this.time,
    required this.isPressed,
    required this.index,
  });
  final String title;
  final String time;
  final bool isPressed;
  final int index;

  @override
  State<PrayerCard> createState() => _PrayerCardState();
}

class _PrayerCardState extends State<PrayerCard> {
  @override
  void initState() {
    super.initState();
    setProgress();
  }

  setProgress() async {
    Provider.of<PrayerProvider>(context, listen: false).completion =
        await SharedPrefs.getCompSharedPrefs("progress");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "  ${widget.title} Prayer",
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
                        widget.time,
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
              FutureBuilder(
                future: SharedPrefs.getBoolSharedPrefs("${widget.index + 1}"),
                builder: (context, snapshot) {
                  return FutureBuilder(
                    future: SharedPrefs.getCompSharedPrefs("p"),
                    builder: (context, snapshott) {
                      return IconButton(
                          onPressed: () {
                            switch (widget.index) {
                              case 0:
                                if (snapshot.data == false) {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("1", true);
                                    SharedPrefs.setCompSharedPrefs(
                                        "p", (snapshott.data ?? 0) - (1 / 6));
                                  });
                                } else {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("1", false);
                                    SharedPrefs.setCompSharedPrefs(
                                        "p", (snapshott.data ?? 0) + (1 / 6));
                                  });
                                }

                              case 1:
                                if (snapshot.data == false) {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("2", true);
                                  });
                                } else {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("2", false);
                                  });
                                }

                              case 2:
                                if (snapshot.data == false) {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("3", true);
                                  });
                                } else {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("3", false);
                                  });
                                }

                              case 3:
                                if (snapshot.data == false) {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("4", true);
                                  });
                                } else {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("4", false);
                                  });
                                }

                              case 4:
                                if (snapshot.data == false) {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("5", true);
                                  });
                                } else {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("5", false);
                                  });
                                }

                              case 5:
                                if (snapshot.data == false) {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("6", true);
                                  });
                                } else {
                                  setState(() {
                                    SharedPrefs.setBoolSharedPrefs("6", false);
                                  });
                                }
                            }
                            if (snapshot.data == false) {
                              setState(() {
                                Provider.of<PrayerProvider>(context,
                                        listen: false)
                                    .setCompletion(1 / 6);
                              });
                            } else if (snapshot.data == true) {
                              setState(() {
                                Provider.of<PrayerProvider>(context,
                                        listen: false)
                                    .setCompletion(-1 / 6);
                              });
                            }
                            print(snapshot.data);
                            print(widget.index);
                            print((Provider.of<PrayerProvider>(context,
                                            listen: false)
                                        .completion ??
                                    0) *
                                100);
                          },
                          icon: snapshot.data!
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
                  );
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
    );
  }
}
