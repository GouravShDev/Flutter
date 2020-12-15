import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/ChartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      var weekday = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;

      for (int i = 0; i < recentTransaction.length; i++) {
        if (weekday.day == recentTransaction[i].date.day &&
            weekday.month == recentTransaction[i].date.month &&
            weekday.year == recentTransaction[i].date.year) {
          totalAmount += recentTransaction[i].amount;
        }
      }

      return {"day": DateFormat.E().format(weekday), "amount": totalAmount};
    }).reversed.toList();
  }

  double get totalSpending {
    // for(int i=0; i<groupedTransactionValues.length;i++){
    //   sum += groupedTransactionValues[i]['amount'];
    // }
    return groupedTransactionValues.fold(
        0.0, (sum, element) => sum += element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                amount: tx['amount'],
                label: tx['day'],
                percentage: totalSpending == 0.0 ? 0.0 : (tx['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
