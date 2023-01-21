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
