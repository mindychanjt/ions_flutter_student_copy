// import 'package:flutter/material.dart';
/* STEP 0: Remove the "/*" on line 2 and "*/" on line_

// STEP 1: explain Stateless vs Stateful:
class MyBrick extends StatelessWidget {
//STEP 2: set up the fields in a Dart class
  brickX


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
          height: 
          width: 
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}

*/