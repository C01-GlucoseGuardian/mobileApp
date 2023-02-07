import 'package:glucose_guardian/models/paziente.dart';

class Tutore {
  String? codiceFiscale;
  String? nome;
  String? cognome;
  String? dataNascita;
  String? indirizzo;
  String? telefono;
  String? email;
  String? sesso;
  List<Paziente>? pazienteList;

  Tutore(
      {this.codiceFiscale,
      this.nome,
      this.cognome,
      this.dataNascita,
      this.indirizzo,
      this.telefono,
      this.email,
      this.sesso,
      this.pazienteList});

  Tutore.fromJson(Map<String, dynamic> json) {
    codiceFiscale = json['codiceFiscale'];
    nome = json['nome'];
    cognome = json['cognome'];
    dataNascita = json['dataNascita'];
    indirizzo = json['indirizzo'];
    telefono = json['telefono'];
    email = json['email'];
    sesso = json['sesso'];
    if (json['pazienteList'] != null) {
      pazienteList = <Paziente>[];
      json['pazienteList'].forEach((v) {
        pazienteList!.add(Paziente.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codiceFiscale'] = codiceFiscale;
    data['nome'] = nome;
    data['cognome'] = cognome;
    data['dataNascita'] = dataNascita;
    data['indirizzo'] = indirizzo;
    data['telefono'] = telefono;
    data['email'] = email;
    data['sesso'] = sesso;
    if (pazienteList != null) {
      data['pazienteList'] = pazienteList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
