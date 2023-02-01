class Farmaco {
  int? id;
  String? nomeFarmaco;
  String? principioAttivo;
  String? confezione;

  Farmaco({this.id, this.nomeFarmaco, this.principioAttivo, this.confezione});

  Farmaco.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomeFarmaco = json['nomeFarmaco'];
    principioAttivo = json['principioAttivo'];
    confezione = json['confezione'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nomeFarmaco'] = this.nomeFarmaco;
    data['principioAttivo'] = this.principioAttivo;
    data['confezione'] = this.confezione;
    return data;
  }
}
