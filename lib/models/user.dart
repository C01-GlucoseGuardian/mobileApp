//TODO: user model from api
/// User model
class User {
  final String nome;
  final String cognome;

  final String codiceFiscale;
  final DateTime dataNascita;
  final String indirizzo;
  final String telefono;
  final String email;
  final String tipoDiabete;
  final String comorbilita;
  final String farmaciAssunti;
  final int periodoDiMonitoraggio;

  User(
    this.nome,
    this.cognome,
    this.codiceFiscale,
    this.dataNascita,
    this.indirizzo,
    this.telefono,
    this.email,
    this.tipoDiabete,
    this.comorbilita,
    this.farmaciAssunti,
    this.periodoDiMonitoraggio,
  );
}
