import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

Particle explodingParticle(Vector2 origin, MaterialColor color) {
  double distanceToMove = 15.0;
  return Particle.generate(
    lifespan: 0.8,
    count: 12,
    generator: (i) {
      //simulate bomb explosion
      final angle = Random().nextDouble() * pi * 2;
      final distance = Random().nextDouble() * distanceToMove;
      final position = origin.clone();
      position.x += cos(angle) * distance;
      position.y += sin(angle) * distance;
      final speed = Random().nextDouble() * 100 + 50;
      final direction = (position - origin).normalized();
      return AcceleratedParticle(
        acceleration: direction * speed * -1,
        child: CircleParticle(
          radius: 4.0,
          paint: Paint()..color = color,
        ),
      );
    },
  );
}

Particle explodeBrickParticle(Paint paint) {
  return Particle.generate(
    lifespan: 3.0, // lifespan of the particles
    // Random count between 20 and 30
    count: 20 + Random().nextInt(10), // Increase the number of particles
    generator: (i) {
      // Simulate a brick explosion
      final angle = Random().nextDouble() * pi * 2;
      final distance = Random().nextDouble() * 20;
      final position = Vector2(0, 0);
      position.x += cos(angle) * distance;
      position.y += sin(angle) * distance;
      final speed = Random().nextDouble() * 250 +
          100; // Adjust the speed of the particles
      final direction = (position - Vector2(0, 0)).normalized();
      return AcceleratedParticle(
        acceleration: direction * speed * -1,
        child: CircleParticle(
          radius: 6.0, // Adjust the size of the particles
          paint: paint, // Adjust the color of the particles
        ),
      );
    },
  );
}
