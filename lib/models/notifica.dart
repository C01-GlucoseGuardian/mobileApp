import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/general.dart';

class Notifica {
  int? id;
  String? messaggio;
  String? data;
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
    data = json['data'];
    ora = timeOfDayFromApiStringWithSeconds(json['ora']);
    stato = json['stato'];
    pazienteOggetto = json['pazienteOggetto'];
    pazienteDestinatario = json['pazienteDestinatario'];
    tutoreDestinatario = json['tutoreDestinatario'];
    adminDestinatario = json['adminDestinatario'];
    dottoreDestinatario = json['dottoreDestinatario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['messaggio'] = this.messaggio;
    data['data'] = this.data;
    data['ora'] = this.ora;
    data['stato'] = this.stato;
    data['pazienteOggetto'] = this.pazienteOggetto;
    data['pazienteDestinatario'] = this.pazienteDestinatario;
    data['tutoreDestinatario'] = this.tutoreDestinatario;
    data['adminDestinatario'] = this.adminDestinatario;
    data['dottoreDestinatario'] = this.dottoreDestinatario;
    return data;
  }
}
