import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:ions_flutter/ball.dart';
// import 'package:ions_flutter/brick.dart'; // uncomment this line
import 'package:ions_flutter/coverscreen.dart';
import 'package:ions_flutter/gameoverscreen.dart';
import 'package:ions_flutter/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

enum Direction { UP, DOWN, LEFT, RIGHT }

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Ticker _ticker;

  // Game state variables
  final FocusNode _focusNode = FocusNode();
  bool hasGameStarted = false;
  bool isGameOver = false;

  // Ball variables
  double ballX = 0;
  double ballY = 0;
  static const double ballXIncrements = 0.02;
  static const double ballYIncrements = 0.01;
  Direction ballXDirection = Direction.LEFT;
  Direction ballYDirection = Direction.DOWN;

  // Player variables
  double playerX = -0.2;
  static const double playerWidth = 0.4;

  /* STEP 4: configure the brick properties with values
  // Brick configuration
  static const double brickWidth =
  static const double brickHeight = 
  static const double brickGap = 
  static const 
  static const double wallGap =
  static const double firstBrickX = 
  static const double firstBrickY = 
  */

  // Brick list
  /*  STEP 5: add an empty brick list
  List
  */

  @override
  void initState() {
    super.initState();
    bricks = generateBricks(1); // Start with 3 rows
    _ticker = createTicker((Duration elapsed) {
      if (hasGameStarted && !isGameOver) {
        setState(() {
          updateDirection();
          moveBall();
          // checkForBrokenBricks();

          if (isPlayerDead()) {
            isGameOver = true;
            _ticker.stop();
          }
        });
      }
    });
  }

  void startGame() {
    setState(() {
      hasGameStarted = true;
    });
    _ticker.start();
  }

  void moveBall() {
    if (ballXDirection == Direction.LEFT) {
      ballX -= ballXIncrements;
    } else if (ballXDirection == Direction.RIGHT) {
      ballX += ballXIncrements;
    }

    if (ballYDirection == Direction.UP) {
      ballY -= ballYIncrements;
    } else if (ballYDirection == Direction.DOWN) {
      ballY += ballYIncrements;
    }
  }

  void updateDirection() {
    // Ball collision with player paddle
    if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
      ballYDirection = Direction.UP;
    } else if (ballY <= -1) {
      ballYDirection = Direction.DOWN;
    }

    // Ball collision with walls
    if (ballX >= 1) {
      ballXDirection = Direction.LEFT;
    } else if (ballX <= -1) {
      ballXDirection = Direction.RIGHT;
    }
  }

  /* STEP 7: CHECK FOR BROKEN BRICKS
  void checkForBrokenBricks() {
    for (int i = 0; i < bricks.length; i++) {
      final brick = bricks[i];
      if (
        
      ) {
        setState(() {
          brick[2] = 
          final collisionSide = findMin({
            'left': (brick[0] - ballX).abs(),
            'right': (brick[0] + brickWidth - ballX).abs(),
            'top': (brick[1] - ballY).abs(),
            'bottom': (brick[1] + brickHeight - ballY).abs(),
          });

          switch (collisionSide) {
            case 'left':
              ballXDirection = Direction.LEFT;
              break;
            case 'right':
              ballXDirection = Direction.RIGHT;
              break;
            case 'top':
              ballYDirection = Direction.UP;
              break;
            case 'bottom':
              ballYDirection = Direction.DOWN;
              break;
          }
        });
      }
    }
    */

    // Add a new row of bricks if all are broken
    if (bricks.every((brick) => brick[2])) {
      addBrickRow();
    }
  }

  /*STEP 8: CREATE A NEW BRICK WHEN ALL BRICKS ARE BROKEN
  void addBrickRow() {

  }
  */

  String findMin(Map<String, double> distances) {
    return distances.entries.reduce((a, b) => a.value < b.value ? a : b).key;
  }

  bool isPlayerDead() {
    return ballY >= 1; // Ball falls below screen
  }

  void moveLeft() {
    if (playerX > -1) {
      setState(() {
        playerX -= 0.2;
      });
    }
  }

  void moveRight() {
    if (playerX + playerWidth < 1) {
      setState(() {
        playerX += 0.2;
      });
    }
  }

  void resetGame() {
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      isGameOver = false;
      hasGameStarted = false;

      /* STEP 9: GENERATE 1 ROW OF BRICKS 
      bricks = generateBricks(1); // Reset with number of rows of bricks
      */
    });
  }

  /* STEP 10: CREATES A GRID OF BRICKS FOR THE GAME
  List
    
  */

  @override
  void dispose() {
    _focusNode.dispose();
    _ticker.dispose();
    super.dispose();
  }

 // STEP 6: EXPLAIN WIDGET, PARTICULARLY ON BRICK
  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          moveLeft();
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          moveRight();
        } else if (event.logicalKey == LogicalKeyboardKey.keyK) {
          setState(() {
            isGameOver = true;
          });
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                CoverScreen(
                  hasGameStarted: hasGameStarted,
                  isGameOver: isGameOver,
                ),
                GameOverScreen(
                  isGameOver: isGameOver,
                  function: resetGame,
                ),
                MyBall(
                  ballX: ballX,
                  ballY: ballY,
                  hasGameStarted: hasGameStarted,
                  isGameOver: isGameOver,
                ),
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),
                /*
                for (var brick in bricks)
                  MyBrick(
                    brickX: ,
                    brickY: ,
                    brickBroken: ,
                    brickHeight: brickHeight,
                    brickWidth: brickWidth,
                  ),
                  */
              ],
            ),
          ),
        ),
      ),
    );
  }

