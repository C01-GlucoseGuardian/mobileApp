import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/db.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:hive/hive.dart';

part 'assunzione_farmaco.g.dart';

@HiveType(typeId: kAssunzioneFarmacoHiveTypeID)
class AssunzioneFarmaco {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? idFarmaco;
  @HiveField(2)
  String? dosaggio;
  @HiveField(3)
  TimeOfDay? orarioAssunzione;
  @HiveField(4)
  String? viaDiSomministrazione;
  @HiveField(5)
  String? noteAggiuntive;
  @HiveField(6)
  String? nomeFarmaco;

  @HiveField(7)
  bool? letta;

  AssunzioneFarmaco(
      {this.id,
      this.idFarmaco,
      this.dosaggio,
      this.orarioAssunzione,
      this.viaDiSomministrazione,
      this.noteAggiuntive,
      this.nomeFarmaco});

  AssunzioneFarmaco.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idFarmaco = json['idFarmaco'];
    dosaggio = json['dosaggio'];
    orarioAssunzione =
        timeOfDayFromApiStringNoSeconds(json['orarioAssunzione']);
    viaDiSomministrazione = json['viaDiSomministrazione'];
    noteAggiuntive = json['noteAggiuntive'];
    nomeFarmaco = json['nomeFarmaco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idFarmaco'] = idFarmaco;
    data['dosaggio'] = dosaggio;
    if (orarioAssunzione != null) {
      data['orarioAssunzione'] = formatTime(orarioAssunzione!);
    }
    data['viaDiSomministrazione'] = viaDiSomministrazione;
    data['noteAggiuntive'] = noteAggiuntive;
    data['nomeFarmaco'] = nomeFarmaco;
    return data;
  }
}
