import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';
import 'package:hive/hive.dart';

class HiveAssunzioneFarmacoService {
  static late final Box box;

  static Future init(String boxName) async =>
      box = await Hive.openBox<AssunzioneFarmaco>(boxName);

  static Future clearAndSaveAll(List<AssunzioneFarmaco> data) async {
    box.clear();
    SharedPreferenceService.lastSavedAgenda =
        DateTime.now().millisecondsSinceEpoch;

    for (AssunzioneFarmaco value in data) {
      await box.put(value.id!, value);
      data.add(value);
    }
  }

  static Future setAsRead(int id) async {
    AssunzioneFarmaco farmaco = box.get(id);
    farmaco.letta = true;
    box.delete(id);
    box.put(id, farmaco);
  }

  // if data has not been saved today
  static bool isValid() {
    int lastSavedAgenda = SharedPreferenceService.lastSavedAgenda;
    if (DateTime.fromMillisecondsSinceEpoch(lastSavedAgenda)
            .difference(DateTime.now())
            .inDays !=
        0) {
      box.clear();

      return false;
    }
    return true;
  }

  static Future<List<AssunzioneFarmaco>> getAll() async {
    return box.values.cast<AssunzioneFarmaco>().toList();
  }
}
