import 'package:first_app/Question.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Answer.dart';
class Quiz extends StatelessWidget{
  final List _questions;
  final int _quesIndex;
  Function _buttonPressed;
  Quiz(this._questions,this._quesIndex,this._buttonPressed);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(_questions[_quesIndex]["QuestionText"]),
        ...(_questions[_quesIndex]["Answer"] as List<Map<String,Object>>)
            .map((e) => Answer(e['Option'], () => _buttonPressed(e["Score"]))),
      ],
    );
  }
}