class FeedbackInput {
  String? statoSalute;
  String? oreSonno;
  String? dolori;
  String? svenimenti;

  FeedbackInput(
      {this.statoSalute, this.oreSonno, this.dolori, this.svenimenti});

  FeedbackInput.fromJson(Map<String, dynamic> json) {
    statoSalute = json['statoSalute'];
    oreSonno = json['oreSonno'];
    dolori = json['dolori'];
    svenimenti = json['svenimenti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statoSalute'] = statoSalute;
    data['oreSonno'] = oreSonno;
    data['dolori'] = dolori;
    data['svenimenti'] = svenimenti;
    return data;
  }
}

class Feedback {
  String? statoSalute;
  String? oreSonno;
  String? dolori;
  String? svenimenti;
  String? data;
  String? ora;
  String? idPaziente;
  String? idDottore;

  Feedback(
      {this.statoSalute,
      this.oreSonno,
      this.dolori,
      this.svenimenti,
      this.data,
      this.ora,
      this.idPaziente,
      this.idDottore});

  Feedback.fromJson(Map<String, dynamic> json) {
    statoSalute = json['statoSalute'];
    oreSonno = json['oreSonno'];
    dolori = json['dolori'];
    svenimenti = json['svenimenti'];
    data = json['data'];
    ora = json['ora'];
    idPaziente = json['idPaziente'];
    idDottore = json['idDottore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statoSalute'] = statoSalute;
    data['oreSonno'] = oreSonno;
    data['dolori'] = dolori;
    data['svenimenti'] = svenimenti;
    data['data'] = data;
    data['ora'] = ora;
    data['idPaziente'] = idPaziente;
    data['idDottore'] = idDottore;
    return data;
  }
}
