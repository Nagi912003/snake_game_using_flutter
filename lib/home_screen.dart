import 'package:flutter/material.dart';
import 'package:snake_game/blank_pixel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // grid dimensions
  int rowSize = 10;
  int totalNumberOfCells = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 3,
              child: GridView.builder(physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowSize,
                ),
                itemBuilder: (context, index) {
                  return const BlankPixel();
                },
                itemCount: totalNumberOfCells,
              ),
            ),
            Expanded(child: Container()),
          ],
        ));
  }
}
