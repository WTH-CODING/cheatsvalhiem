import 'package:cheatsvalhiem/models/spawnable_model.dart';
import 'package:postgrest/postgrest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  static Future getSpawnablesFromDB() async {
    PostgrestResponse response = await Supabase.instance.client
        .from('spawnables')
        .select()
        .order("id", ascending: true)
        .execute();
    List<Spawnable> spawnables = response.data.map<Spawnable>((spawnable) {
      return Spawnable.fromJson(spawnable);
    }).toList();
    return spawnables;
  }
}
