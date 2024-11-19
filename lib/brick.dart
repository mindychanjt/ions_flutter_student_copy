import 'package:flutter/material.dart';

// STEP 1: explain Stateless vs Stateful:
class MyBrick extends StatelessWidget {


  /*
 STEP 2:
        set up the fields in a Dart class
  It represents the properties of a "brick" object.
  brickX -> X-coordinate of the brick's position on a screen
  brickY -> Y-coordinate of the brick's position 
  brickHeight -> how tall the brick appears
  brickWidth -> how wide the brick appears
  brickBroken -> true: brick broken, false: brick intact
  */
  final double brickX;
  final double brickY;
  final double brickHeight;
  final double brickWidth;
  final bool brickBroken;

  const MyBrick({
    super.key,
    required this.brickHeight,
    required this.brickWidth,
    required this.brickX,
    required this.brickY,
    required this.brickBroken,
  });

  /*
  sizedbox.shrink() creates a widget with no size (essentially invisible)
  */

  @override
  // step 3: set up what happen to the brick
  Widget build(BuildContext context) {
    if (brickBroken) {
      return const SizedBox.shrink(); // More efficient to hide a widgeet instead of using an empty Container
    }

    return Align(
      alignment: Alignment(
        (2 * brickX + brickWidth) / (2 - brickWidth),
        brickY,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.5), //clips the widget into a rectangle with rounded corners
        child: Container(
          // calculates the brick's height and width as a fraction of the screen's height
          // use Media Query to sized dynamically relative to the screen dimensions
          height: MediaQuery.of(context).size.height * brickHeight / 2,
          width: MediaQuery.of(context).size.width * brickWidth / 2,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
