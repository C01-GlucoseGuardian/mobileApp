import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:intl/intl.dart';

class Notifica {
  int? id;
  String? messaggio;
  DateTime? data;
  TimeOfDay? time;
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
      this.time,
      this.stato,
      this.pazienteOggetto,
      this.pazienteDestinatario,
      this.tutoreDestinatario,
      this.adminDestinatario,
      this.dottoreDestinatario});

  Notifica.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messaggio = json['messaggio'];
    data = DateFormat("dd/MM/yyyy").parse(json["data"]);
    time = timeOfDayFromApiStringWithSeconds(json["time"]);
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
    if (this.data != null) {
      data['data'] = DateFormat("dd/MM/yyy").format(this.data!);
    }
    if (time != null) data['time'] = "${time!.hour}:${time!.minute}:00}";
    data['stato'] = stato;
    data['pazienteOggetto'] = pazienteOggetto;
    data['pazienteDestinatario'] = pazienteDestinatario;
    data['tutoreDestinatario'] = tutoreDestinatario;
    data['adminDestinatario'] = adminDestinatario;
    data['dottoreDestinatario'] = dottoreDestinatario;
    return data;
  }
}
