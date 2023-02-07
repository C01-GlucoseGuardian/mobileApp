class FeedbackInput {
  String idPaziente;
  String statoSalute;
  String oreSonno;
  String dolori;
  String svenimenti;

  FeedbackInput(this.idPaziente, this.statoSalute, this.oreSonno, this.dolori,
      this.svenimenti);

  FeedbackInput.fromJson(Map<String, dynamic> json)
      : idPaziente = json['idPaziente'],
        statoSalute = json['statoSalute'],
        oreSonno = json['oreSonno'],
        dolori = json['dolori'],
        svenimenti = json['svenimenti'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPaziente'] = idPaziente;
    data['statoSalute'] = statoSalute;
    data['oreSonno'] = oreSonno;
    data['dolori'] = dolori;
    data['svenimenti'] = svenimenti;
    return data;
  }
}
