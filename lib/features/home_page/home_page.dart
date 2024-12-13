import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import '../../widgets/PrayerTimesCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  PrayerTimes? prayerTimes;

  @override
  void initState() {
    super.initState();
    calculatePrayerTimes();
  }

  void calculatePrayerTimes() {
    final myCoordinates = Coordinates(23.8041, 90.4152);
    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.hanafi;

    final prayerTime = PrayerTimes.today(myCoordinates, params);
    setState(() {
      prayerTimes = prayerTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrayerTimesCard(prayerTimes: prayerTimes!),
        ],
      ),
    );
  }
}
