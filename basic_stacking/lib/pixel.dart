import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  final color;

  Pixel({this.color});
  //const Pixel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: color,
            )));
  }
}
