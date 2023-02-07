import 'package:intl/intl.dart';

class Dottore {
  String? codiceFiscale;
  String? nome;
  String? cognome;
  DateTime? dataNascita;
  String? indirizzo;
  String? telefono;
  String? email;
  String? sesso;
  String? specializzazione;
  String? codiceAlbo;
  String? nomeStruttura;
  String? indirizzoStruttura;
  int? stato;

  Dottore(
      {this.codiceFiscale,
      this.nome,
      this.cognome,
      this.dataNascita,
      this.indirizzo,
      this.telefono,
      this.email,
      this.sesso,
      this.specializzazione,
      this.codiceAlbo,
      this.nomeStruttura,
      this.indirizzoStruttura,
      this.stato});

  Dottore.fromJson(Map<String, dynamic> json) {
    codiceFiscale = json['codiceFiscale'];
    nome = json['nome'];
    cognome = json['cognome'];
    dataNascita = DateFormat("yyyy/MM/dd").parse(json['dataNascita']);
    indirizzo = json['indirizzo'];
    telefono = json['telefono'];
    email = json['email'];
    sesso = json['sesso'];
    specializzazione = json['specializzazione'];
    codiceAlbo = json['codiceAlbo'];
    nomeStruttura = json['nomeStruttura'];
    indirizzoStruttura = json['indirizzoStruttura'];
    stato = json['stato'];
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
    data['specializzazione'] = specializzazione;
    data['codiceAlbo'] = codiceAlbo;
    data['nomeStruttura'] = nomeStruttura;
    data['indirizzoStruttura'] = indirizzoStruttura;
    data['stato'] = stato;
    return data;
  }
}
