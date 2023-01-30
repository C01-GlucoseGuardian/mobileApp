//TODO: doctor model from api
/// Doctor model
class Doctor {
  final String nome;
  final String cognome;
  final String codiceFiscale;
  final DateTime dataNascita;
  final String indirizzo;
  final String telefono;
  final String email;
  final String specializzazione;
  final String nomeStruttura;
  final String indirizzoStruttura;

  Doctor(
      this.nome,
      this.cognome,
      this.codiceFiscale,
      this.dataNascita,
      this.indirizzo,
      this.telefono,
      this.email,
      this.specializzazione,
      this.nomeStruttura,
      this.indirizzoStruttura);
}
