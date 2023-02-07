import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/general.dart';

class AssunzioneFarmaco {
  int? id;
  int? idFarmaco;
  String? dosaggio;
  TimeOfDay? orarioAssunzione;
  String? viaDiSomministrazione;
  String? noteAggiuntive;
  String? nomeFarmaco;

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
    data['orarioAssunzione'] = orarioAssunzione;
    data['viaDiSomministrazione'] = viaDiSomministrazione;
    data['noteAggiuntive'] = noteAggiuntive;
    data['nomeFarmaco'] = nomeFarmaco;
    return data;
  }
}
