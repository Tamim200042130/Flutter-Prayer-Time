import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrayerTimeAdhanPub extends StatefulWidget {
  const PrayerTimeAdhanPub({super.key});

  @override
  PrayerTimeAdhanPubState createState() => PrayerTimeAdhanPubState();
}

class PrayerTimeAdhanPubState extends State<PrayerTimeAdhanPub> {
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
    final formatter = DateFormat.jm();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: prayerTimes == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Fajr: ${formatter.format(prayerTimes!.fajr)} - ${formatter.format(prayerTimes!.sunrise)}'),
                  Text(
                      'Dhuhr: ${formatter.format(prayerTimes!.dhuhr)} - ${formatter.format(prayerTimes!.asr)}'),
                  Text(
                      'Asr: ${formatter.format(prayerTimes!.asr)} - ${formatter.format(prayerTimes!.maghrib)}'),
                  Text(
                      'Maghrib: ${formatter.format(prayerTimes!.maghrib)} - ${formatter.format(prayerTimes!.isha)}'),
                  Text(
                      'Isha: ${formatter.format(prayerTimes!.isha)} - ${formatter.format(prayerTimes!.fajr)}'),
                ],
              ),
      ),
    );
  }
}
