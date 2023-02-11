import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/glicemia.dart';

void main() {
  group("general functions unit test", () {
    late List<Glicemia> misurazioni;

    setUp(() {
      misurazioni = [
        Glicemia(livelloGlucosio: 100, timestamp: 12903109),
        Glicemia(livelloGlucosio: 200, timestamp: 12903109),
        Glicemia(livelloGlucosio: 300, timestamp: 12903109),
        Glicemia(livelloGlucosio: 400, timestamp: 12903109),
      ];
    });
    test('isGlucoseValueNormal', () {
      try {
        isGlucoseValueNormal(-100);
        fail("no exception thrown");
      } catch (e) {
        expect(e, isA<Exception>());
      }

      try {
        isGlucoseValueNormal(2000000);
        fail("no exception thrown");
      } catch (e) {
        expect(e, isA<Exception>());
      }

      expect(isGlucoseValueNormal(80), isTrue);
      expect(isGlucoseValueNormal(200), isFalse);
    });
    test('getLowest', () {
      try {
        getLowest([]);
        fail("no exception thrown");
      } catch (e) {
        expect(e, isA<Exception>());
      }
      expect(getLowest(misurazioni), equals(misurazioni[0]));
    });
    test('getHighest', () {
      try {
        getHighest([]);
        fail("no exception thrown");
      } catch (e) {
        expect(e, isA<Exception>());
      }

      expect(getHighest(misurazioni), equals(misurazioni[3]));
    });

    test('formatTime', () {
      expect(
          formatTime(const TimeOfDay(hour: 10, minute: 10)), equals("10:10"));
      expect(formatTime(const TimeOfDay(hour: 2, minute: 10)), equals("02:10"));
    });

    test('timeOfDayFromApiStringNoSeconds', () {
      expect(
        timeOfDayFromApiStringNoSeconds("10:10"),
        equals(const TimeOfDay(hour: 10, minute: 10)),
      );
      expect(
        timeOfDayFromApiStringNoSeconds("10:10:10"),
        equals(
          const TimeOfDay(hour: 10, minute: 10),
        ),
      );

      expect(
        timeOfDayFromApiStringNoSeconds("2:20"),
        equals(
          const TimeOfDay(hour: 2, minute: 20),
        ),
      );
    });

    test('timeOfDayFromApiStringWithSeconds', () {
      try {
        timeOfDayFromApiStringWithSeconds("10:10");
        fail("no exception thrown");
      } catch (e) {
        expect(e, isA<Exception>());
      }

      expect(
        timeOfDayFromApiStringWithSeconds("10:10:10"),
        equals(
          const TimeOfDay(hour: 10, minute: 10),
        ),
      );

      expect(
        timeOfDayFromApiStringWithSeconds("2:20:0"),
        equals(
          const TimeOfDay(hour: 2, minute: 20),
        ),
      );
    });
  });
}
