import 'package:flutter/material.dart';
import 'package:snake_game/pixel.dart';
import 'package:snake_game/pixel_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // grid dimensions
  int rowSize = 10;
  int totalNumberOfCells = 100;

  // snake position
  List<int> snakePositions = [0, 1, 2];

  // food position
  int foodPosition = 55;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // score
            Expanded(child: Container(
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
                  }
                  else {
                    return const Pixel(
                      type: PixelType.blank,
                    );
                  }
                },
                itemCount: totalNumberOfCells,
              ),
            ),
            // play button
            Expanded(child: Container(
              child: Center(
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.grey,
                  child: const Text('Play', style: TextStyle(fontSize: 40)),
                ),
              ),
            )),
          ],
        ));
  }
}
