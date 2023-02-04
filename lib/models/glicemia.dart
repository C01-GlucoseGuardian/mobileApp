class Glicemia {
  int? livelloGlucosio;
  int? timestamp;

  Glicemia({this.livelloGlucosio, this.timestamp});

  Glicemia.fromJson(Map<String, dynamic> json) {
    livelloGlucosio = json['livelloGlucosio'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['livelloGlucosio'] = this.livelloGlucosio;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
