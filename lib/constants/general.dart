import 'package:flutter/material.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:intl/intl.dart';

/// 1 for development mode, 2 for staging, 3 for prod
/// this choses the server in constants/api.dart
const int kAppStatus = 1;

/// checks if glucose value is normal or not
bool isGlucoseValueNormal(int value) => value < 100;
const String kGlucoseUOM = "mg/dL";

/// Get lowest measurement in list
Glicemia getLowest(List<Glicemia> list) => list.reduce((value, element) =>
    value.livelloGlucosio! < element.livelloGlucosio! ? value : element);

/// Get highest measurement in list
Glicemia getHighest(List<Glicemia> list) => list.reduce((value, element) =>
    value.livelloGlucosio! > element.livelloGlucosio! ? value : element);

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

/// Get a TimeOfDay instance from a HH:MM String
TimeOfDay timeOfDayFromApiStringNoSeconds(String time) =>
    TimeOfDay.fromDateTime(DateFormat("hh:mm").parse(time));

/// Get a TimeOfDay instance from a HH:MM:SS String
TimeOfDay timeOfDayFromApiStringWithSeconds(String time) =>
    TimeOfDay.fromDateTime(DateFormat("hh:mm:ss").parse(time));
