import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/general.dart';

class Notifica {
  int? id;
  String? messaggio;
  DateTime? data;
  TimeOfDay? ora;
  int? stato;
  String? pazienteOggetto;
  String? pazienteDestinatario;
  String? tutoreDestinatario;
  String? adminDestinatario;
  String? dottoreDestinatario;

  Notifica(
      {this.id,
      this.messaggio,
      this.data,
      this.ora,
      this.stato,
      this.pazienteOggetto,
      this.pazienteDestinatario,
      this.tutoreDestinatario,
      this.adminDestinatario,
      this.dottoreDestinatario});

  Notifica.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messaggio = json['messaggio'];
    data = DateTime.parse(json['data']);
    ora = timeOfDayFromApiStringWithSeconds(json['ora']);
    stato = json['stato'];
    pazienteOggetto = json['pazienteOggetto'];
    pazienteDestinatario = json['pazienteDestinatario'];
    tutoreDestinatario = json['tutoreDestinatario'];
    adminDestinatario = json['adminDestinatario'];
    dottoreDestinatario = json['dottoreDestinatario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['messaggio'] = messaggio;
    data['data'] = data;
    data['ora'] = ora;
    data['stato'] = stato;
    data['pazienteOggetto'] = pazienteOggetto;
    data['pazienteDestinatario'] = pazienteDestinatario;
    data['tutoreDestinatario'] = tutoreDestinatario;
    data['adminDestinatario'] = adminDestinatario;
    data['dottoreDestinatario'] = dottoreDestinatario;
    return data;
  }
}
