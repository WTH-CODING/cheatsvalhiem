import 'package:hive/hive.dart';
import 'package:cheatsvalhiem/models/spawnable_model.dart';

class HiveHelper {
  static Future<Box> openSpawnablesBox() async {
    Box box = await Hive.openBox('spawnables');
    return box;
  }

  static Future<void> saveSpawnablesData(List<Spawnable> spawnables) async {
    Box box = await openSpawnablesBox();
    for (Spawnable spawnable in spawnables) {
      await box.put(spawnable.id, spawnable.toJson());
    }
    return;
  }

  static Future<List<Spawnable>> getAllSpawnables() async {
    Box box = await openSpawnablesBox();
    Iterable<dynamic> data = box.values;
    List<Spawnable> spawnables = data
        .map<Spawnable>((spawnable) => Spawnable.fromJson(spawnable))
        .toList();
    return spawnables;
  }

  // static Future<List<Spawnable>> getSpawnablesByCount({
  //   int skip = 0,
  //   int limit = 50,
  // }) async {
  //   Box box = await openSpawnablesBox();
  //   Iterable<dynamic> data =
  //       await box.valuesBetween(startKey: skip, endKey: limit);
  //   List<Spawnable> spawnables = data
  //       .map<Spawnable>((spawnable) => Spawnable.fromJson(spawnable))
  //       .toList();
  //   return spawnables;
  // }

  static Future<void> clearHiveBoxes() async {
    Box box = await Hive.openBox('spawnables');
    await box.clear();
    await box.close();
    return;
  }
}
