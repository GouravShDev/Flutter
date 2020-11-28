import 'package:first_app/Quiz.dart';
import 'package:first_app/result.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(first_app());
}

class first_app extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _first_appState();
  }
}

class _first_appState extends State<first_app> {
  var _quesIndex = 0;
  var _score = 0;
  final _questions = const [
    {
      "QuestionText": "What's is your favorite Color",
      "Answer": [
        {"Option": "Green", "Score": 10},
        {"Option": "Blue", "Score": 5},
        {"Option": "Pink", "Score": 4},
        {"Option": "Red", "Score": 3}
      ]
    },
    {
      "QuestionText": "What's is your favorite animal",
      "Answer": [
        {"Option": "Dog", "Score": 10},
        {"Option": "Cats", "Score": 5},
        {"Option": "Lion", "Score": 4},
      ]
    },
  ];

  void _buttonPressed(int score) {
    setState(() {
      _quesIndex++;
      _score += score;
    });
  }
  void _reset(){
    setState(() {
      _quesIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('First App'),
        ),
        body: _quesIndex < _questions.length
            ? Quiz(_questions, _quesIndex, _buttonPressed)
            : Result(_score, _reset),
      ),
    );
  }
}
