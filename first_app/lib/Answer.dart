import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function handler;
  final String AnswerString;

  Answer(this.AnswerString,this.handler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        child: Text(AnswerString),
        onPressed: handler,
        color: Colors.blue,
        textColor: Colors.black,
      ),
    );
  }
}
