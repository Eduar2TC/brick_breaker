//screen sizes
import 'dart:math';

import 'package:flutter/material.dart';

const gameWidth = 820.0;
const gameHeight = 1600.0;
const ballRadius = gameWidth * 0.02; //ball radius is 2% of game width
//bat
const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 2;
const batStep = gameWidth * 0.05;
//bricks
//generate 10 random colors list
final List<Color> colors = List.generate(
    10,
    (index) => Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0));

const brickGutter = gameWidth * 0.015;
final brickWidth =
    (gameWidth - (brickGutter * (colors.length + 1))) / colors.length;
const brickHeight = gameHeight * 0.02;
const brickRows = 5;
const difficultyModifier = 1.03;
