import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;

  ChartBar({this.label, this.amount, this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 15,
            child: FittedBox(child: Text("Rs ${amount.toStringAsFixed(0)}"),),),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 100,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage.toDouble(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(label),
      ],
    );
  }
}
