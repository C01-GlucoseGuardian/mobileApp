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
    dataNascita = DateTime.parse(json['dataNascita']);
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codiceFiscale'] = this.codiceFiscale;
    data['nome'] = this.nome;
    data['cognome'] = this.cognome;
    data['dataNascita'] = this.dataNascita;
    data['indirizzo'] = this.indirizzo;
    data['telefono'] = this.telefono;
    data['email'] = this.email;
    data['sesso'] = this.sesso;
    data['specializzazione'] = this.specializzazione;
    data['codiceAlbo'] = this.codiceAlbo;
    data['nomeStruttura'] = this.nomeStruttura;
    data['indirizzoStruttura'] = this.indirizzoStruttura;
    data['stato'] = this.stato;
    return data;
  }
}
