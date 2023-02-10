import 'package:glucose_guardian/models/numero_utile.dart';
import 'package:intl/intl.dart';

class Paziente {
  String? codiceFiscale;
  String? nome;
  String? cognome;
  DateTime? dataNascita;
  String? indirizzo;
  String? telefono;
  String? email;
  String? sesso;
  String? tipoDiabete;
  String? comorbilita;
  String? farmaciAssunti;
  int? periodoDiMonitoraggio;
  List<NumeroUtile>? numeriUtili;

  Paziente(
      {this.codiceFiscale,
      this.nome,
      this.cognome,
      this.dataNascita,
      this.indirizzo,
      this.telefono,
      this.email,
      this.sesso,
      this.tipoDiabete,
      this.comorbilita,
      this.farmaciAssunti,
      this.periodoDiMonitoraggio,
      this.numeriUtili});

  Paziente.fromJson(Map<String, dynamic> json) {
    codiceFiscale = json['codiceFiscale'];
    nome = json['nome'];
    cognome = json['cognome'];
    dataNascita = DateFormat("dd/MM/yyyy").parse(json['dataNascita']);
    indirizzo = json['indirizzo'];
    telefono = json['telefono'];
    email = json['email'];
    sesso = json['sesso'];
    tipoDiabete = json['tipoDiabete'];
    comorbilita = json['comorbilita'];
    farmaciAssunti = json['farmaciAssunti'];
    periodoDiMonitoraggio = json['periodoDiMonitoraggio'];
    if (json['numeriUtili'] != null) {
      numeriUtili = <NumeroUtile>[];
      json['numeriUtili'].forEach((v) {
        numeriUtili!.add(NumeroUtile.fromJson(v));
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
    data['tipoDiabete'] = tipoDiabete;
    data['comorbilita'] = comorbilita;
    data['farmaciAssunti'] = farmaciAssunti;
    data['periodoDiMonitoraggio'] = periodoDiMonitoraggio;
    if (numeriUtili != null) {
      data['numeriUtili'] = numeriUtili!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
