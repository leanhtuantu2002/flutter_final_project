import 'dart:async';

import 'package:basic_stacking/button.dart';
import 'package:basic_stacking/pixel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfSquares = 160;
  var direction = 'left';

  List<int> piece = [];
  List<int> landed = [100000];
  List<int> close = [];
  int level = 0;

  void startGame() {
    piece = [
      numberOfSquares - 3 - level * 10,
      numberOfSquares - 2 - level * 10,
      numberOfSquares - 1 - level * 10
    ];

    Timer.periodic(Duration(milliseconds: 250), (timer) {
      if (checkWinner()) {
        _showDialog();
        timer.cancel();
      }

      if (piece.first % 10 == 0) {
        direction = 'right';
      } else if (piece.last % 10 == 9) {
        direction = 'left';
      }

      setState(() {
        if (direction == 'left') {
          for (int i = 0; i < piece.length; i++) {
            piece[i] -= 1;
          }
        } else {
          for (int i = 0; i < piece.length; i++) {
            piece[i] += 1;
          }
        }
      });
    });
  }

  bool checkWinner() {
    if (landed.last < 10) {
      return true;
    } else {
      return false;
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Winner!'),
          );
        });
  }

  void stack() {
    level++;
    for (int i = 0; i < piece.length; i++) {
      landed.add(piece[i]);
    }

    if (level < 4) {
      piece = [
        numberOfSquares - 3 - level * 10,
        numberOfSquares - 2 - level * 10,
        numberOfSquares - 1 - level * 10
      ];
    } else if (level >= 4 && level < 8) {
      piece = [
        numberOfSquares - 2 - level * 10,
        numberOfSquares - 1 - level * 10
      ];
    } else if (level >= 8) {
      piece = [numberOfSquares - 1 - level * 10];
    }

    checkStack();
  }

  void checkStack() {
    for (int i = 0; i < landed.length; i++) {
      if (!landed.contains(landed[i] + 10) &&
          (landed[i] + 10) < numberOfSquares - 1) {
        landed.remove(landed[i]);
      }
    }
    for (int i = 0; i < landed.length; i++) {
      if (!landed.contains(landed[i] + 10) &&
          (landed[i] + 10) < numberOfSquares - 1) {
        landed.remove(landed[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: GridView.builder(
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10),
                itemBuilder: (BuildContext context, int index) {
                  if (piece.contains(index)) {
                    return Pixel(
                      color: Colors.white,
                    );
                  } else if (landed.contains(index)) {
                    return Pixel(
                      color: Colors.white,
                    );
                  } else {
                    return Pixel(
                      color: Colors.grey[900],
                    );
                  }
                }),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.grey[400],
                  child: Center(
                      child: Text('Here is Ads banner',
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.grey[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  function: startGame,
                  child: Text(
                    'P L A Y',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                MyButton(
                  function: stack,
                  child: Text(
                    'S T O P',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
