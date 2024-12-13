import 'package:flutter/material.dart';

class TextStyleConstants {
  static TextStyle bold18([Color? color]) {
    return color == null
        ? TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black)
        : TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: color);
  }

  static TextStyle bold16([Color? color]) {
    return color == null
        ? TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)
        : TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color);
  }

  static TextStyle regular16([Color? color]) {
    return color == null
        ? TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black)
        : TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: color);
  }

  static TextStyle regular12([Color? color]) {
    return color == null
        ? TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black)
        : TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: color);
  }
}