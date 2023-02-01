class NumeroUtile {
  String? numero;

  NumeroUtile({this.numero});

  NumeroUtile.fromJson(Map<String, dynamic> json) {
    numero = json['numero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numero'] = this.numero;
    return data;
  }
}
