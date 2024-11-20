/* STEP 0: Remove "/* */" on line 1 and line 43 respectively

import 'package:flutter/material.dart';

// STEP 1: Stateless vs Stateful
class MyBrick extends StatelessWidget {


  
 // STEP 2: set up the fields in a Dart class 
  final 

  const MyBrick({
    super.key,
    required this.brickHeight,
    required this.brickWidth,
    required this.brickX,
    required this.brickY,
    required this.brickBroken,
  });

  // STEP 3: Set up the widget, SizedBox.shrink, height & width
  @override
  Widget build(BuildContext context) {
    if 

    return Align(
      alignment: Alignment(
        (2 * brickX + brickWidth) / (2 - brickWidth),
        brickY,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.5), 
        child: Container(
          height: 
          width: 
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
*/
