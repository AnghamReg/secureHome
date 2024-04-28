import 'package:flutter/material.dart';

enum TemperatureIcon {
  low,
  moderate,
  high,
}

class TemperatureIconHelper {
  static Icon getIcon(double temp) {
    TemperatureIcon ti;
    if (temp <= 10) {
      ti = TemperatureIcon.low;
    } else if (temp > 10 && temp <= 20) {
      ti = TemperatureIcon.moderate;
    } else {
      ti = TemperatureIcon.high;
    }
    switch (ti) {
      case TemperatureIcon.low:
        return const Icon(
          Icons.ac_unit,
          size: 40,
          color: Colors.blue,
        ); // Change this to your low temperature icon
      case TemperatureIcon.moderate:
        return const Icon(
          Icons.wb_cloudy,
          size: 40,
          color: Colors.grey,
        ); // Change this to your moderate temperature icon
      case TemperatureIcon.high:
        return const Icon(
          Icons.wb_sunny,
          size: 40,
          color: Colors.amber,
        ); // Change this to your high temperature icon
      default:
        return const Icon(
          Icons.error,
          size: 40,
          color: Colors.red,
        );
        ; // Default icon for unknown temperature range
    }
  }
}
