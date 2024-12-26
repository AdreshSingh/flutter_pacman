import 'dart:math';

import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final String direction;
  const Player({
    super.key,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return switch (direction) {
      "left" => Transform.rotate(
          angle: pi,
          child: Image.asset('lib/images/pacman.png'),
        ),
      "up" => Transform.rotate(
          angle: 3 * pi * 1 / 2,
          child: Image.asset('lib/images/pacman.png'),
        ),
      "down" => Transform.rotate(
          angle: pi * 1 / 2,
          child: Image.asset('lib/images/pacman.png'),
        ),
      _ => Transform.rotate(
          angle: 0,
          child: Image.asset('lib/images/pacman.png'),
        ),
    };
  }
}
