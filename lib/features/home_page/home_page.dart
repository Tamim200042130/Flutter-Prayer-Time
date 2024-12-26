import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
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
Future<void> calculatePrayerTimes() async {
  final prefs = await SharedPreferences.getInstance();
  final selectedCountry = prefs.getString('selectedCountry')?.trim();
  final selectedState = prefs.getString('selectedState')?.trim();
  final selectedCity = prefs.getString('selectedCity')?.trim();
  final selectedMethod = prefs.getString('selectedMethod');
  final selectedMadhab = prefs.getString('selectedMadhab');

  Coordinates myCoordinates;

  if (selectedState != null && selectedState.isNotEmpty) {
    myCoordinates = await getCoordinatesFromAddress('$selectedState, $selectedCountry');
  } else if (selectedCity != null && selectedCity.isNotEmpty) {
    myCoordinates = await getCoordinatesFromAddress('$selectedCity, $selectedCountry');
  } else if (selectedCountry != null && selectedCountry.isNotEmpty) {
    myCoordinates = await getCoordinatesFromAddress(selectedCountry);
  } else {
    myCoordinates = Coordinates(23.8041, 90.4152);
  }

  final params = CalculationMethod.values
      .firstWhere(
        (method) => method.name == selectedMethod,
        orElse: () => CalculationMethod.karachi,
      )
      .getParameters();

  params.madhab = Madhab.values.firstWhere(
    (madhab) => madhab.name == selectedMadhab,
    orElse: () => Madhab.shafi,
  );

  final prayerTime = PrayerTimes.today(myCoordinates, params);
  setState(() {
    prayerTimes = prayerTime;
  });
}

Future<Coordinates> getCoordinatesFromAddress(String address) async {
  List<Location> locations = await locationFromAddress(address);
  if (locations.isNotEmpty) {
    final location = locations.first;
    return Coordinates(location.latitude, location.longitude);
  }
  return Coordinates(23.8041, 90.4152);
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
          if (prayerTimes != null) PrayerTimesCard(prayerTimes: prayerTimes!),
        ],
      ),
    );
  }
}
