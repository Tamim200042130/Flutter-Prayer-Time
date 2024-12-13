import 'package:flutter/material.dart';

class ColorConstants {
  static const Color primary = Color.fromRGBO(1, 172, 106, 1);
  static const Color primaryAccent = Color.fromRGBO(64, 159, 122, 1.0);
  static const Color secondary = Color.fromRGBO(237, 240, 243, 1);
  static const Color error = Color.fromRGBO(255, 0, 0, 1.0);
  static const Color errorToast = Color.fromRGBO(255, 60, 60, 1.0);

  static const Color neutral20 = Color.fromRGBO(221, 223, 227, 1);
  static const Color neutral50 = Color.fromRGBO(127, 135, 147, 1);
  static const Color neutral90 = Color.fromRGBO(34, 37, 42, 1);

  static const Color textFieldBorderColor = Color.fromRGBO(100, 100, 100, 1.0);

  static const List<BoxShadow> shadow08250 = [
    BoxShadow(color: Color.fromRGBO(83, 89, 144, 0.07), offset: Offset(0, 8.0), blurRadius: 25.0, spreadRadius: 0.0),
    BoxShadow(color: Colors.white, offset: Offset(0.0, 0.0), blurRadius: 0.0, spreadRadius: 0.0)
  ];
  static const List<BoxShadow> shadow0340 = [
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.05), offset: Offset(0, 3.0), blurRadius: 4.0, spreadRadius: 0.0),
    BoxShadow(color: Colors.white, offset: Offset(0.0, 0.0), blurRadius: 0.0, spreadRadius: 0.0)
  ];
}