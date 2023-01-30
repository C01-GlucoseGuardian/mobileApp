import 'package:flutter/material.dart';
import 'package:glucose_guardian/models/farmaco.dart';
import 'package:glucose_guardian/models/measurement.dart';
import 'package:glucose_guardian/models/notifica.dart';
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

String loremIpsum1024Characters =
    """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc convallis efficitur est, eu accumsan turpis dignissim a. Duis sed fermentum tellus, nec sodales odio. Curabitur at dolor nec odio ullamcorper suscipit vel et justo. Nunc condimentum leo leo, in pulvinar justo commodo quis. Mauris vel pharetra risus, a laoreet massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eget hendrerit turpis.

Sed turpis diam, rutrum at libero vel, vehicula tempus nisi. Quisque porttitor id purus vitae efficitur. Nam porttitor quis est a dignissim. Sed at dictum lacus, a accumsan urna. Etiam nec tortor odio. Quisque pellentesque semper suscipit. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum fermentum lorem efficitur est ultrices, et elementum lorem tincidunt. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut nec elit nec urna sodales consequat eget sit amet tellus. Duis eu turpis ante. Nullam non elit tincidunt.

""";

List<Notifica> kMockNotifiche = [
  Notifica("Prova notifica 1", DateTime(2023, 1, 27), TimeOfDay.now(),
      StatoNotifica.received),
  Notifica("Prova notifica 2", DateTime(2023, 1, 27),
      const TimeOfDay(hour: 11, minute: 00), StatoNotifica.received),
  Notifica(loremIpsum1024Characters, DateTime(2023, 1, 27),
      const TimeOfDay(hour: 20, minute: 30), StatoNotifica.received),
  Notifica(
      "Prova notifica 4 con testo moolto lungo e una parola luuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuunghissima. ",
      DateTime(2023, 1, 27),
      const TimeOfDay(hour: 22, minute: 30),
      StatoNotifica.dismissed),
];
