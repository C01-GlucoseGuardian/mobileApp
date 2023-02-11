// chat-gpt generated, tbh lol
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';

void main() {
  group('AssunzioneFarmaco', () {
    test('fromJson() correctly parses json', () {
      final Map<String, dynamic> json = {
        'id': 1,
        'idFarmaco': 2,
        'dosaggio': '3mg',
        'orarioAssunzione': '10:00:00',
        'viaDiSomministrazione': 'oral',
        'noteAggiuntive': 'Take with food',
        'nomeFarmaco': 'Aspirin'
      };

      final assunzioneFarmaco = AssunzioneFarmaco.fromJson(json);

      expect(assunzioneFarmaco.id, json['id']);
      expect(assunzioneFarmaco.idFarmaco, json['idFarmaco']);
      expect(assunzioneFarmaco.dosaggio, json['dosaggio']);
      expect(assunzioneFarmaco.orarioAssunzione,
          const TimeOfDay(hour: 10, minute: 0));
      expect(assunzioneFarmaco.viaDiSomministrazione,
          json['viaDiSomministrazione']);
      expect(assunzioneFarmaco.noteAggiuntive, json['noteAggiuntive']);
      expect(assunzioneFarmaco.nomeFarmaco, json['nomeFarmaco']);
    });

    test('toJson() correctly returns json', () {
      final assunzioneFarmaco = AssunzioneFarmaco(
          id: 1,
          idFarmaco: 2,
          dosaggio: '3mg',
          orarioAssunzione: const TimeOfDay(hour: 10, minute: 0),
          viaDiSomministrazione: 'oral',
          noteAggiuntive: 'Take with food',
          nomeFarmaco: 'Aspirin');

      final json = assunzioneFarmaco.toJson();

      expect(json['id'], assunzioneFarmaco.id);
      expect(json['idFarmaco'], assunzioneFarmaco.idFarmaco);
      expect(json['dosaggio'], assunzioneFarmaco.dosaggio);
      expect(json['orarioAssunzione'],
          formatTime(assunzioneFarmaco.orarioAssunzione!));
      expect(json['viaDiSomministrazione'],
          assunzioneFarmaco.viaDiSomministrazione);
      expect(json['noteAggiuntive'], assunzioneFarmaco.noteAggiuntive);
      expect(json['nomeFarmaco'], assunzioneFarmaco.nomeFarmaco);
    });

    test('fromJson() handles missing data', () {
      final Map<String, dynamic> json = {
        'id': 1,
        'idFarmaco': 2,
        'dosaggio': '3mg',
        'orarioAssunzione': '10:00:00',
        'viaDiSomministrazione': 'oral',
        'noteAggiuntive': 'Take with food',
      };

      final assunzioneFarmaco = AssunzioneFarmaco.fromJson(json);

      expect(assunzioneFarmaco.id, json['id']);
      expect(assunzioneFarmaco.idFarmaco, json['idFarmaco']);
      expect(assunzioneFarmaco.dosaggio, json['dosaggio']);
      expect(
        assunzioneFarmaco.orarioAssunzione,
        const TimeOfDay(hour: 10, minute: 0),
      );
      expect(assunzioneFarmaco.viaDiSomministrazione,
          json['viaDiSomministrazione']);
      expect(assunzioneFarmaco.noteAggiuntive, json['noteAggiuntive']);
      expect(assunzioneFarmaco.nomeFarmaco, null);
    });
  });
}
