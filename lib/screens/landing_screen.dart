// ignore_for_file: non_constant_identifier_names

import 'package:cheatsvalhiem/models/spawnable_model.dart';
import 'package:cheatsvalhiem/services/supabase_services.dart';
import 'package:cheatsvalhiem/widgets/cheat_card.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<Spawnable> spawnables = [];
  List<Spawnable> spawnables2 = [];
  List<bool> toggleList = List.generate(16, (index) => false);
  @override
  initState() {
    super.initState();
    getInitalData();
    toggleList[0] = true;
  }

  getInitalData() async {
    setState(() {
      loading = true;
    });
    spawnables = await SupabaseServices.getSpawnablesFromDB();
    setState(() {
      spawnables2 = spawnables;
      loading = false;
    });
  }

  searchCheats() {
    spawnables2 = spawnables;
    setState(() {
      spawnables2 = spawnables2
          .where((element) => element.itemName
              .toLowerCase()
              .contains(_controller.text.toLowerCase()))
          .toList();
    });
  }

  bool loading = true;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        controller: _controller,
                        onChanged: (e) async {
                          await searchCheats();
                        },
                        cursorColor: Colors.white,
                        textCapitalization: TextCapitalization.words,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Enter query",
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _controller.clear();
                                  setState(() {
                                    spawnables2 = spawnables;
                                  });
                                },
                                icon: Icon(Icons.clear),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await searchCheats();
                                },
                                icon: Icon(Icons.search),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  TagsBarWidget(),
                  Flexible(
                    child: Container(
                      child: ListView.builder(
                        itemCount: spawnables2.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CheatCard(
                            spawnable: spawnables2[index],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  TagsBarWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 16),
            TagsWidget('All', 0),
            TagsWidget('Items', 1),
            TagsWidget('Armor', 2),
            TagsWidget('Ammo', 3),
            TagsWidget('Weapon', 4),
            TagsWidget('Tool', 5),
            TagsWidget('Trinket', 6),
            TagsWidget('Enemy', 7),
            TagsWidget('Boss', 8),
            TagsWidget('Food', 9),
            TagsWidget('Potion/Mead', 10),
            TagsWidget('Vehicle/Cart', 11),
            TagsWidget('NPC', 12),
            TagsWidget('Trophy', 13),
            TagsWidget('Spawner', 14),
            TagsWidget('Misc', 15),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  TagsWidget(String tag, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          spawnables2 = spawnables;
        } else {
          spawnables2 =
              spawnables.where((element) => element.type == tag).toList();
        }
        setState(() {
          toggleList.clear();
          toggleList = List.generate(16, (index) => false);
          toggleList[index] = true;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: toggleList[index]
                ? Colors.redAccent.withOpacity(0.8)
                : Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: Text(
              '$tag',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
