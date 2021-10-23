import 'package:cheatsvalhiem/widgets/cheat_card.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return CheatCard();
          },
        ),
      ),
    );
  }
}
