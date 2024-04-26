import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/menu/rectangle_button_menu.dart';
import 'levels/level_one.dart';

class Levels extends StatelessWidget {
  const Levels({
    super.key,
    required this.level,
  });
  final LevelOne level;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme()
            .apply(
              bodyColor: const Color(0xff184e77),
              displayColor: const Color(0xff184e77),
            )
            .copyWith(
              headlineLarge: GoogleFonts.pressStart2p(
                fontSize: 35,
                color: const Color(0xff184e77),
              ),
            ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                //generate grid game levels
                child: GridView.count(
                    crossAxisCount: 3,
                    //space between grid items
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 25,
                    children: [
                      LevelButton(
                        level: level,
                        levelString: 'Level 1',
                      ),
                      LevelButton(
                        level: level,
                        levelString: 'Level 2',
                      ),
                      LevelButton(
                        level: level,
                        levelString: 'Level 3',
                      ),
                      LevelButton(
                        level: level,
                        levelString: 'Level 4',
                      ),
                      LevelButton(
                        level: level,
                        levelString: 'Level 5',
                      ),
                      LevelButton(
                        level: level,
                        levelString: 'Level 6',
                      ),
                      LevelButton(
                        level: level,
                        levelString: 'Level 7',
                      ),
                      const LevelButton(
                        //level: level,
                        levelString: 'Level 8',
                      ),
                      const RectangleButton(
                        icon: Icons.arrow_back,
                        //material accent color
                        btnColor: Colors.blueAccent,
                        textColor: Colors.white,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LevelButton extends StatelessWidget {
  const LevelButton({super.key, this.level, required this.levelString});

  final LevelOne? level;
  final String levelString;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.black12,
        borderRadius: BorderRadius.circular(40),
        border: const Border(
            top: BorderSide(color: Colors.white70, width: 2),
            bottom: BorderSide(color: Colors.white70, width: 6),
            left: BorderSide(color: Colors.white70, width: 4),
            right: BorderSide(color: Colors.white70, width: 4)),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: const Border(
              top: BorderSide(color: Colors.black12, width: 3),
              bottom: BorderSide(color: Colors.black12, width: 8),
              left: BorderSide(color: Colors.black12, width: 3),
              right: BorderSide(color: Colors.black12, width: 3)),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            //radius
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          onPressed: () {
            //navigate to level1
            level?.startGame();
          },
          child: Text(
            levelString,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
