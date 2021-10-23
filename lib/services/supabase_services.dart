import 'dart:convert';

import 'package:cheatsvalhiem/models/spawnable_model.dart';
import 'package:postgrest/postgrest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  static Future getSpawnablesFromDB() async {
    print('FLAG1');
    PostgrestResponse response =
        await Supabase.instance.client.from('spawnables').select().execute();
    print('FLAG2');
    List<Spawnable> spawnables = json
        .decode(response.data)
        .map<Spawnable>((spawnable) => Spawnable.fromJson(spawnable))
        .toList();
    print('FLAG3');
    print(spawnables.length);
    print('FLAG4');
  }
}
