import 'package:brick_breaker/src/screens/home_body.dart';
import 'package:flutter/material.dart';

import 'levels/level_one.dart';
// Add this import

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final LevelOne level;
  //getter game
  LevelOne get getLevel => level;
  @override
  void initState() {
    super.initState();
    level = LevelOne();
  }

  @override
  Widget build(BuildContext context) {
    return HomeBody(level: level);
  }
}
