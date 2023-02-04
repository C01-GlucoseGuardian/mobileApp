import 'package:glucose_guardian/models/numero_utile.dart';

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
    dataNascita = DateTime.parse(json['dataNascita']);
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['codiceFiscale'] = this.codiceFiscale;
    data['nome'] = this.nome;
    data['cognome'] = this.cognome;
    data['dataNascita'] = this.dataNascita;
    data['indirizzo'] = this.indirizzo;
    data['telefono'] = this.telefono;
    data['email'] = this.email;
    data['sesso'] = this.sesso;
    data['tipoDiabete'] = this.tipoDiabete;
    data['comorbilita'] = this.comorbilita;
    data['farmaciAssunti'] = this.farmaciAssunti;
    data['periodoDiMonitoraggio'] = this.periodoDiMonitoraggio;
    if (this.numeriUtili != null) {
      data['numeriUtili'] = this.numeriUtili!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
