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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statoSalute'] = this.statoSalute;
    data['oreSonno'] = this.oreSonno;
    data['dolori'] = this.dolori;
    data['svenimenti'] = this.svenimenti;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statoSalute'] = this.statoSalute;
    data['oreSonno'] = this.oreSonno;
    data['dolori'] = this.dolori;
    data['svenimenti'] = this.svenimenti;
    data['data'] = this.data;
    data['ora'] = this.ora;
    data['idPaziente'] = this.idPaziente;
    data['idDottore'] = this.idDottore;
    return data;
  }
}
