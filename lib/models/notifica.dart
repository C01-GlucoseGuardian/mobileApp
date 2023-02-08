import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:intl/intl.dart';

class Notifica {
  String? pazienteDestinatario;
  String? tutoreDestinatario;
  String? dottoreDestinatario;
  String? messaggio;
  DateTime? data;
  TimeOfDay? time;
  int? stato;

  Notifica(
      {this.pazienteDestinatario,
      this.tutoreDestinatario,
      this.dottoreDestinatario,
      this.messaggio,
      this.data,
      this.time,
      this.stato});

  Notifica.fromJson(Map<String, dynamic> json) {
    pazienteDestinatario = json['pazienteDestinatario'];
    tutoreDestinatario = json['tutoreDestinatario'];
    dottoreDestinatario = json['dottoreDestinatario'];
    messaggio = json['messaggio'];
    data = DateFormat("dd/MM/yyyy").parse(json['data']);
    time = timeOfDayFromApiStringWithSeconds(json['time']);
    stato = json['stato'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pazienteDestinatario'] = pazienteDestinatario;
    data['tutoreDestinatario'] = tutoreDestinatario;
    data['dottoreDestinatario'] = dottoreDestinatario;
    data['messaggio'] = messaggio;
    data['data'] = data;
    data['time'] = time;
    data['stato'] = stato;
    return data;
  }
}
