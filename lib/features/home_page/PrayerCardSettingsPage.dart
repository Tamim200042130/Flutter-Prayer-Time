import 'package:adhan/adhan.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:prayer_time_flutter/features/home_page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/CityStatePicker.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/app_button.dart';

class PrayerCardSettingsPage extends StatefulWidget {
  const PrayerCardSettingsPage({super.key});

  @override
  PrayerCardSettingsPageState createState() => PrayerCardSettingsPageState();
}

class PrayerCardSettingsPageState extends State<PrayerCardSettingsPage> {
  final List<CalculationMethod> calculationMethods = [
    CalculationMethod.muslim_world_league,
    CalculationMethod.egyptian,
    CalculationMethod.karachi,
    CalculationMethod.umm_al_qura,
    CalculationMethod.dubai,
    CalculationMethod.moon_sighting_committee,
    CalculationMethod.north_america,
    CalculationMethod.kuwait,
    CalculationMethod.qatar,
    CalculationMethod.singapore,
    CalculationMethod.tehran,
    CalculationMethod.turkey,
    CalculationMethod.other,
  ];

  final List<Madhab> madhabs = [
    Madhab.hanafi,
    Madhab.shafi,
  ];

  Madhab? selectedMadhab = Madhab.hanafi;
  CalculationMethod? selectedMethod = CalculationMethod.muslim_world_league;
  bool isLoading = false;
  String? error;
  CscCountry? selectedCountry;
  String? selectedState;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedMadhab = Madhab.values.firstWhere(
              (madhab) => madhab.name == prefs.getString('selectedMadhab'),
          orElse: () => Madhab.hanafi);
      selectedMethod = CalculationMethod.values.firstWhere(
              (method) => method.name == prefs.getString('selectedMethod'),
          orElse: () => CalculationMethod.muslim_world_league);
      selectedCountry = CscCountry.values.firstWhere(
              (country) =>
          country
              .toString()
              .split('.')
              .last == prefs.getString('selectedCountry'),
          orElse: () => CscCountry.values.first);
      selectedState = prefs.getString('selectedState');
      selectedCity = prefs.getString('selectedCity');
    });
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedMadhab', selectedMadhab?.name ?? 'hanafi');
    await prefs.setString(
        'selectedMethod', selectedMethod?.name ?? 'muslim_world_league');
    await prefs.setString('selectedCountry', selectedCountry
        ?.toString()
        .split('.')
        .last ?? '');
    await prefs.setString('selectedState', selectedState ?? '');
    await prefs.setString('selectedCity', selectedCity ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Prayer Card Settings',
        backButtonNavigationTo: HomePage(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
            ? Center(child: Text('Error: $error'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Madhab:'),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<Madhab>(
                    title: const Text('Hanafi'),
                    value: Madhab.hanafi,
                    groupValue: selectedMadhab,
                    onChanged: (Madhab? value) {
                      setState(() {
                        selectedMadhab = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<Madhab>(
                    title: const Text('Shafi'),
                    value: Madhab.shafi,
                    groupValue: selectedMadhab,
                    onChanged: (Madhab? value) {
                      setState(() {
                        selectedMadhab = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Calculation Method:'),
            DropdownButton<CalculationMethod>(
              value: selectedMethod,
              hint: const Text('Select a method'),
              onChanged: (CalculationMethod? newValue) {
                setState(() {
                  selectedMethod = newValue;
                });
              },
              items: calculationMethods
                  .map<DropdownMenuItem<CalculationMethod>>((
                  CalculationMethod value) {
                return DropdownMenuItem<CalculationMethod>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Select City and State:'),
            CityStatePicker(
              onCountryChanged: (value) {
                setState(() {
                  selectedCountry = CscCountry.values.firstWhere(
                          (country) =>
                      country
                          .toString()
                          .split('.')
                          .last == value,
                      orElse: () => CscCountry.values.first);
                });
              },
              onStateChanged: (value) {
                setState(() {
                  selectedState = value;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
              defaultCountry: selectedCountry,
              defaultState: selectedState,
              defaultCity: selectedCity,
            ),
            // if (selectedCountry != null) Text('Country: ${selectedCountry!
            //     .toString()
            //     .split('.')
            //     .last}'),
            // if (selectedState != null) Text('State: $selectedState'),
            // if (selectedCity != null) Text('City: $selectedCity'),
            const Spacer(),
            AppButton(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  await savePreferences();
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage()),
                  );
                } catch (e) {
                  setState(() {
                    error = e.toString();
                  });
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              title: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}