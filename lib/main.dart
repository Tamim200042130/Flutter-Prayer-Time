import 'package:flutter/material.dart';
import 'package:prayer_time_flutter/features/adhan_pub/prayer_times_adhan_pub.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Prayer Times',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PrayerTimeAdhanPub(),
    );
  }
}
