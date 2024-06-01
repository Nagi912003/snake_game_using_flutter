import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/pixel.dart';
import 'package:snake_game/pixel_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum snakeDirection { up, down, left, right }

class _HomeScreenState extends State<HomeScreen> {
  // grid dimensions
  int rowSize = 10;
  int totalNumberOfCells = 100;

  // snake position
  List<int> snakePositions = [0, 1, 2];

  // snake direction is initially right
  snakeDirection currentDirection = snakeDirection.right;

  // food position
  int foodPosition = 55;

  // start the game
  void startGame() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        // keep the snake moving
        if(gameOver()){
          timer.cancel();

          // show dialog
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Game Over'),
                content: Text('Score: ${snakePositions.length - 3}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      snakePositions = [0, 1, 2];
                      Navigator.of(context).pop();
                      startGame();
                    },
                    child: const Text('Play Again'),
                  )
                ],
              );
            },
          );
        }

        moveSnake();


      });
    });
  }

  void moveSnake() {
    switch (currentDirection) {
      case snakeDirection.up:
        if(snakePositions.last < rowSize){
          snakePositions.add(snakePositions.last + totalNumberOfCells - rowSize);
        } else {
          snakePositions.add(snakePositions.last - rowSize);
        }
        break;
      case snakeDirection.down:
        if(snakePositions.last >= totalNumberOfCells - rowSize){
          snakePositions.add(snakePositions.last - totalNumberOfCells + rowSize);
        } else {
          snakePositions.add(snakePositions.last + rowSize);
        }
        break;
      case snakeDirection.left:
        //if the snake is at the left edge
        if (snakePositions.last % rowSize == 0) {
          snakePositions.add(snakePositions.last + rowSize - 1);
        } else {
          snakePositions.add(snakePositions.last - 1);
        }
        break;
      case snakeDirection.right:
        //if the snake is at the right edge
        if (snakePositions.last % rowSize == 9) {
          snakePositions.add(snakePositions.last - rowSize + 1);
        } else {
          snakePositions.add(snakePositions.last + 1);
        }
        break;
    }
    // snake eats the food
    if (snakePositions.last == foodPosition) {
      // generate new food
      eatFood();
    } else {
      // remove the tail
      snakePositions.removeAt(0);
    }
  }

  // eatFood
  void eatFood() {
    // the food is not on the snake
    while (snakePositions.contains(foodPosition)) {
      foodPosition = Random().nextInt(totalNumberOfCells);
    }
  }

  // game over
  bool gameOver() {
    // the game is over if the snake hits itself
    if (snakePositions.length != snakePositions.toSet().toList().length) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // score
            Expanded(
                child: Container(
              child: Center(
                child: Text(
                  'Score: ${snakePositions.length - 3}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            )),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0 &&
                      currentDirection != snakeDirection.up) {
                    currentDirection = snakeDirection.down;
                  } else if (details.delta.dy < 0 &&
                      currentDirection != snakeDirection.down) {
                    // move up
                    currentDirection = snakeDirection.up;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0 &&
                      currentDirection != snakeDirection.left) {
                    // move right
                    currentDirection = snakeDirection.right;
                  } else if (details.delta.dx < 0 &&
                      currentDirection != snakeDirection.right) {
                    // move left
                    currentDirection = snakeDirection.left;
                  }
                },
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowSize,
                  ),
                  itemBuilder: (context, index) {
                    if (snakePositions.contains(index)) {
                      return const Pixel(
                        type: PixelType.snake,
                      );
                    } else if (index == foodPosition) {
                      return const Pixel(
                        type: PixelType.food,
                      );
                    } else {
                      return const Pixel(
                        type: PixelType.blank,
                      );
                    }
                  },
                  itemCount: totalNumberOfCells,
                ),
              ),
            ),
            // play button
            Expanded(
                child: Container(
              child: Center(
                child: MaterialButton(
                  onPressed: startGame,
                  color: Colors.grey,
                  child: const Text('Play', style: TextStyle(fontSize: 40)),
                ),
              ),
            )),
          ],
        ));
  }
}
