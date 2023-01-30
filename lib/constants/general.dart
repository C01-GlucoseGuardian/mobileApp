import 'package:flutter/material.dart';
import 'package:glucose_guardian/models/measurement.dart';

/// checks if glucose value is normal or not
///
/// TODO: change UOM to mg/dL
bool isGlucoseValueNormal(double value) => value > 3.9 && value <= 5.5;
const String kGlucoseUOM = "mmol/L";

/// Get lowest measurement in list
Measurement getLowest(List<Measurement> list) => list
    .reduce((value, element) => value.value < element.value ? value : element);

/// Get highest measurement in list
Measurement getHighest(List<Measurement> list) => list
    .reduce((value, element) => value.value > element.value ? value : element);

/// Define a "wrapper class" to be used by provider to find the bottomNavigationBar
/// index up in the widget tree not confusing it with other simple integers that
/// may be present
class BottomNavigationBarIndex extends ChangeNotifier {
  int _index;

  BottomNavigationBarIndex(this._index);

  int get index => _index;

  set index(int index) {
    _index = index;

    notifyListeners();
  }
}

/// Navigator paths of the homepage of paziente
const List<String> kHomeNavigatorPaths = [
  "home",
  "agenda",
  "notifiche",
  "dottore",
  "profilo"
];

/// Returns the formatted time in the hh:mm format
String formatTime(TimeOfDay time) =>
    "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
