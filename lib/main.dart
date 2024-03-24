import 'package:flutter/material.dart';
import 'package:prayer_app/provider/login_provider.dart';
import 'package:prayer_app/provider/prayer_provider.dart';
import 'package:prayer_app/view/screens/base_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(create: (context) => PrayerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff52BF95)),
          useMaterial3: true,
        ),
        home: const BaseScreen(),
      ),
    );
  }
}
