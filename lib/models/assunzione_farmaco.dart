import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/general.dart';

class AssunzioneFarmaco {
  int? id;
  int? idFarmaco;
  int? dosaggio;
  TimeOfDay? orarioAssunzione;
  String? viaDiSomministrazione;
  String? noteAggiuntive;

  AssunzioneFarmaco(
      {this.id,
      this.idFarmaco,
      this.dosaggio,
      this.orarioAssunzione,
      this.viaDiSomministrazione,
      this.noteAggiuntive});

  AssunzioneFarmaco.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idFarmaco = json['idFarmaco'];
    dosaggio = json['dosaggio'];
    orarioAssunzione =
        timeOfDayFromApiStringNoSeconds(json['orarioAssunzione']);
    viaDiSomministrazione = json['viaDiSomministrazione'];
    noteAggiuntive = json['noteAggiuntive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['idFarmaco'] = this.idFarmaco;
    data['dosaggio'] = this.dosaggio;
    data['orarioAssunzione'] = this.orarioAssunzione;
    data['viaDiSomministrazione'] = this.viaDiSomministrazione;
    data['noteAggiuntive'] = this.noteAggiuntive;
    return data;
  }
}
