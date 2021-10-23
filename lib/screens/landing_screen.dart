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
  @override
  initState() {
    super.initState();
    getInitalData();
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
    spawnables2 = spawnables2
        .where((element) => element.itemName.contains(_controller.text))
        .toList();
    setState(() {
      spawnables2 = spawnables2
          .where((element) => element.itemName.contains(_controller.text))
          .toList();
    });
  }

  bool loading = true;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await SupabaseServices.getSpawnablesFromDB();
        },
      ),
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
                                onPressed: () => _controller.clear(),
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
}
