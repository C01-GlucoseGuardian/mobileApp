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
