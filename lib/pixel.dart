import 'package:flutter/material.dart';
import 'package:snake_game/pixel_type.dart';

class Pixel extends StatelessWidget {
  const Pixel({super.key, required this.type});
  final PixelType type;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: type == PixelType.blank? Colors.grey[900]: type == PixelType.snake? Colors.white: Colors.green,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
