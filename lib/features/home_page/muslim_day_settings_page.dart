import 'package:flutter/material.dart';

class LocationSettingsPage extends StatefulWidget {
  const LocationSettingsPage({super.key});

  @override
  LocationSettingsPageState createState() => LocationSettingsPageState();
}

class LocationSettingsPageState extends State<LocationSettingsPage> {
  String selectedCountry = 'Bangladesh';
  String selectedDistrict = 'Dhaka';
  int selectedLocationType = 0;

  // static final CameraPosition _dhakaCameraPosition = const CameraPosition(
  //   target: LatLng(23.8103, 90.4125),
  //   zoom: 10,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B4965),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'লোকেশন সেটিংস',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'সালাত ও সাহরি-ইফতারের সময় সঠিক ভাবে হিসাব করার জন্য আপনার লোকেশন সেট করুন।',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'দেশ নির্বাচন করুন',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: selectedCountry,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items:
                            ['Bangladesh', 'Saudi Arabia'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCountry = newValue!;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Default City: Dhaka',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Text(
                      'লোকেশন সেট করার পদ্ধতি সিলেক্ট করুন',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RadioListTile(
                      title: const Text('জিপিএস ভিত্তিক (ইসলামিক ফাউন্ডেশন)'),
                      value: 0,
                      groupValue: selectedLocationType,
                      onChanged: (value) {
                        setState(() {
                          selectedLocationType = value as int;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    RadioListTile(
                      title:
                          const Text('GPS লোকেশন ভিত্তিক (অপেক্ষাকৃত নির্ভুল)'),
                      value: 1,
                      groupValue: selectedLocationType,
                      onChanged: (value) {
                        setState(() {
                          selectedLocationType = value as int;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'জেলা নির্বাচন করুন',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: selectedDistrict,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: ['Dhaka'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedDistrict = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Container(
                    //   height: 200,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(8),
                    //     child: GoogleMap(
                    //       initialCameraPosition: _dhakaCameraPosition,
                    //       zoomControlsEnabled: false,
                    //       markers: {
                    //         const Marker(
                    //           markerId: MarkerId('dhaka'),
                    //           position: LatLng(23.8103, 90.4125),
                    //         ),
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'SAVE',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
