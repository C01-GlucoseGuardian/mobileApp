import 'package:glucose_guardian/models/assunzione_farmaco.dart';

class Terapia {
  int? id;
  String? idPaziente;
  String? idDottore;
  String? dataInizio;
  List<AssunzioneFarmaco>? farmaci;

  Terapia(
      {this.id,
      this.idPaziente,
      this.idDottore,
      this.dataInizio,
      this.farmaci});

  Terapia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPaziente = json['idPaziente'];
    idDottore = json['idDottore'];
    dataInizio = json['dataInizio'];
    if (json['farmaci'] != null) {
      farmaci = <AssunzioneFarmaco>[];
      json['farmaci'].forEach((v) {
        farmaci!.add(new AssunzioneFarmaco.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idPaziente'] = this.idPaziente;
    data['idDottore'] = this.idDottore;
    data['dataInizio'] = this.dataInizio;
    if (this.farmaci != null) {
      data['farmaci'] = this.farmaci!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
