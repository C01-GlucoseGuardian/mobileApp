import 'package:flutter/material.dart';

class Farmaco {
  final String name;
  final TimeOfDay time;
  final String dose; // or double?
  final String routeOfAdministration;

  Farmaco(this.name, this.time, this.dose, this.routeOfAdministration);
}
