import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pacman/ghost.dart';
import 'package:flutter_pacman/path.dart';
import 'package:flutter_pacman/pixels.dart';
import 'package:flutter_pacman/player.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static int numberOfRow = 11;
  int numberOfSquare = numberOfRow * 17;

  final List<int> barriers = [
    ...List.generate(11, (int index) => index + 1),
    -1,
    ...List.generate(17, (int index) => index * 11),
    -1,
    ...List.generate(17, (int index) => index + ((index * 10) + 10)),
    -1,
    ...List.generate(11, (int index) => index + 176),
    // row 1
    24, 35, 46, 57,
    // top c
    26, 37, 38, 39, 28,
    // row 2
    30, 41, 52, 63,
    // row 1 small
    59, 70,
    // row 2 small
    61, 72,
    // first lane
    78, 79, 80, 81, 83, 84, 85, 86,

    // other half
    // row 1
    123, 134, 145, 156,
    // top c
    158, 147, 148, 149, 160,
    // row 2
    129, 140, 151, 162,
    // row 1 small
    114, 125,
    // row 2 small
    116, 127,
    // first lane
    100, 101, 102, 103, 105, 106, 107, 108
  ];

  //? player starting position
  int player = numberOfRow * 15 + 1;

  //? direction of player
  String direction = "right";

  // ? consumed berries
  List<int> food = [];

  // ? game started
  bool preGame = true;

  // ? mouth closed
  bool moutClosed = false;

  // ? couting score
  int score = 0;

  // ? ghost position
  int ghost = 20;
  // ? ghost movement pattern logic
  List<int> ghostPattern = [20, 31, 42, 53, 64, 75, 74, 73, 62, 51, 40, 29, 18];

  // ? ghost movement initiation
  int ghostIndex = 0;
  final ghostDuration = const Duration(milliseconds: 500);
  void makeMoveGhost() {
    if (ghost == -1) return;
    ghost = ghostPattern[ghostIndex % 13];
  }

  void startGame() {
    //? getting the index of berries
    const duration = Duration(milliseconds: 200);
    preGame = false;
    // getFood();
    Timer.periodic(
      duration,
      (timer) {
        makeMoveGhost();
        if (ghost == player) {
          ghost = -1;
        } else if (ghost != -1) {
          ghostIndex++;
        }
        setState(() {
          moutClosed = !moutClosed;
        });

        if (food.contains(player)) {
          food.remove(player);
          score++;
        }

        switch (direction) {
          case "up":
            movement(() {
              player -= numberOfRow;
            }, player - numberOfRow);
            break;
          case "down":
            movement(() {
              player += numberOfRow;
            }, player + numberOfRow);
            break;
          case "right":
            movement(() {
              player++;
            }, player + 1);
            break;
          case "left":
            movement(() {
              player--;
            }, player - 1);
            break;
        }
      },
    );
  }

  // ? getfood
  void getFood() {
    for (int i = 0; i < numberOfSquare; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  //? movement controller
  void movement(makeMove, int player) {
    if (!barriers.contains(player)) {
      setState(makeMove);
    }
  }

  //? initialzing details onstartup
  @override
  void initState() {
    setState(() {
      getFood();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(barriers);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                // print(details.delta);
                if (details.delta.dy < 0) {
                  direction = "up";
                } else if (details.delta.dy > 0) {
                  direction = "down";
                }
                // print(direction);
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
                // print(direction);
                // print(details.delta);
              },
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numberOfSquare,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numberOfRow,
                ),
                itemBuilder: (context, index) {
                  if (moutClosed && player == index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  } else if (player == index) {
                    return Player(
                      direction: direction,
                    );
                  } else if (barriers.contains(index)) {
                    return Pixels(
                      innerColor: Colors.blue[900]!,
                      outerColor: Colors.blue[500]!,
                      child: const Text("    "),
                    );
                  }
                  if (ghost == index) {
                    return const Ghost();
                  }
                  if (food.contains(index) || preGame) {
                    return const Paths(
                      innerColor: Colors.yellow,
                      outerColor: Colors.black,
                      child: Text("  "),
                    );
                  } else {
                    return const Paths(
                      innerColor: Colors.black,
                      outerColor: Colors.black,
                      child: Text("  "),
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Score: $score",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                GestureDetector(
                  onTap: startGame,
                  child: const Text(
                    "P L A Y",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
