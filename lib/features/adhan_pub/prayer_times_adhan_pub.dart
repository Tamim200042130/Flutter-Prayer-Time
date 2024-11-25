import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class PrayerTimeAdhanPub extends StatefulWidget {
  const PrayerTimeAdhanPub({super.key});

  @override
  _PrayerTimeAdhanPubState createState() => _PrayerTimeAdhanPubState();
}

class _PrayerTimeAdhanPubState extends State<PrayerTimeAdhanPub> {
  Position? _currentPosition;
  PrayerTimes? _prayerTimes;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show a dialog
      _showLocationServiceDisabledDialog();
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, show a dialog
        _showPermissionDeniedDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, show a dialog
      _showPermissionDeniedForeverDialog();
      return;
    }

    // Permissions are granted, get the current location
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
      _calculatePrayerTimes();
    });
  }

  void _calculatePrayerTimes() {
    if (_currentPosition != null) {
      final myCoordinates = Coordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      final params = CalculationMethod.muslim_world_league.getParameters();
      params.madhab = Madhab.hanafi;

      final prayerTimes = PrayerTimes.today(myCoordinates, params);
      setState(() {
        _prayerTimes = prayerTimes;
      });
    }
  }

  void _showLocationServiceDisabledDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text('Please enable location services to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Denied'),
        content:
            const Text('Location permission is required to show prayer times.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedForeverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Denied Forever'),
        content: const Text(
            'Location permission is permanently denied. Please enable it from settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.jm(); // 12-hour format

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _prayerTimes == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fajr: ${formatter.format(_prayerTimes!.fajr)}'),
                  Text('Dhuhr: ${formatter.format(_prayerTimes!.dhuhr)}'),
                  Text('Asr: ${formatter.format(_prayerTimes!.asr)}'),
                  Text('Maghrib: ${formatter.format(_prayerTimes!.maghrib)}'),
                  Text('Isha: ${formatter.format(_prayerTimes!.isha)}'),
                ],
              ),
      ),
    );
  }
}
