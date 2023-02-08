import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:hive/hive.dart';

class HiveAssunzioneFarmacoService {
  static late final Box box;

  static Future init(String boxName) async =>
      box = await Hive.openBox<AssunzioneFarmaco>(boxName);

  static Future clearAndSaveAll(List<AssunzioneFarmaco> data) async {
    //TODO: set save date in sharedPreferences, because it should be reset after 24 hours
    box.clear();

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

  static Future<List<AssunzioneFarmaco>> getAll() async {
    // check shared Preferences if date is valid, if not return [] and clear db
    print(box.values.cast<AssunzioneFarmaco>().toList());
    return box.values.cast<AssunzioneFarmaco>().toList();
  }
}
