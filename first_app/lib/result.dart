import 'dart:ui';

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int _score;
  final Function reset;

  Result(this._score, this.reset);

  String get resultGet {
    String res;
    if (_score > 15) {
      res = "First Result";
    } else if (_score > 20) {
      res = "Second Result";
    } else {
      res = "Third Result";
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultGet,
            style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold),
          ),
          FlatButton(
            child: Text("Reset"),
            onPressed: reset,
          ),
        ],
      ),
    );
  }
}
