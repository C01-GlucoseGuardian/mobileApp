import 'package:flutter/material.dart';
import 'package:glucose_guardian/models/farmaco.dart';
import 'package:glucose_guardian/models/measurement.dart';
import 'package:glucose_guardian/models/user.dart';

User kMockUser = User("Vito", "Piegari");
List<Measurement> kMockMeasurements = [
  Measurement(3.5, DateTime.now().subtract(const Duration(hours: 1))),
  Measurement(4, DateTime.now().subtract(const Duration(hours: 2))),
  Measurement(4.5, DateTime.now().subtract(const Duration(hours: 3))),
  Measurement(7.5, DateTime.now().subtract(const Duration(hours: 4))),
  Measurement(1.5, DateTime.now().subtract(const Duration(hours: 5))),
  Measurement(7.5, DateTime.now().subtract(const Duration(hours: 6))),
  Measurement(9.5, DateTime.now().subtract(const Duration(hours: 7))),
  Measurement(6.5, DateTime.now().subtract(const Duration(hours: 8))),
  Measurement(3.5, DateTime.now().subtract(const Duration(hours: 1))),
  Measurement(4, DateTime.now().subtract(const Duration(hours: 2))),
  Measurement(4.5, DateTime.now().subtract(const Duration(hours: 3))),
  Measurement(7.5, DateTime.now().subtract(const Duration(hours: 4))),
  Measurement(1.5, DateTime.now().subtract(const Duration(hours: 5))),
  Measurement(7.5, DateTime.now().subtract(const Duration(hours: 6))),
  Measurement(9.5, DateTime.now().subtract(const Duration(hours: 7))),
  Measurement(6.5, DateTime.now().subtract(const Duration(hours: 8))),
];

List<Farmaco> kMockFarmaci = [
  Farmaco("Farmaco di nome 1", const TimeOfDay(hour: 10, minute: 30), "0.25 ug",
      "Orale"),
  Farmaco("Farmaco di nome 2", const TimeOfDay(hour: 11, minute: 00), "0.25 mg",
      "Orale"),
  Farmaco("Farmaco di nome 3", const TimeOfDay(hour: 13, minute: 30), "1.25 ug",
      "Orale"),
  Farmaco("Farmaco di nome 4", const TimeOfDay(hour: 20, minute: 30), "1,4 mg",
      "Orale"),
  Farmaco("Farmaco di nome huehgiufka", const TimeOfDay(hour: 22, minute: 30),
      "12 kg", "Endovenosa"),
];
