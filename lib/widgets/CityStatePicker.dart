import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CityStatePicker extends StatelessWidget {
  final void Function(String?)? onCountryChanged;
  final void Function(String?)? onStateChanged;
  final void Function(String?)? onCityChanged;
  final CscCountry? defaultCountry;
  final String? defaultState;
  final String? defaultCity;

  const CityStatePicker({
    super.key,
    this.onCountryChanged,
    this.onStateChanged,
    this.onCityChanged,
    this.defaultCountry,
    this.defaultState,
    this.defaultCity,
  });

  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      showStates: true,
      showCities: true,
      flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
      dropdownDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        border: Border.all(color: ColorConstants.primary, width: 1),
      ),
      disabledDropdownDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      countrySearchPlaceholder: "Country",
      stateSearchPlaceholder: "State",
      citySearchPlaceholder: "City",
      countryDropdownLabel: "*Country",
      stateDropdownLabel: "*State",
      cityDropdownLabel: "*City",
      selectedItemStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      dropdownHeadingStyle: const TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      dropdownItemStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      dropdownDialogRadius: 10.0,
      searchBarRadius: 10.0,
      onCountryChanged: (value) {
        if (onCountryChanged != null) {
          onCountryChanged!(value);
        }
      },
      onStateChanged: (value) {
        if (onStateChanged != null) {
          onStateChanged!(value);
        }
      },
      onCityChanged: (value) {
        if (onCityChanged != null) {
          onCityChanged!(value);
        }
      },
      defaultCountry: defaultCountry,
    );
  }
}
