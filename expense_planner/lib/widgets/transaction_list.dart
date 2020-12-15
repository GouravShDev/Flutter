import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _removeTransaction;
  final Function _editTransaction;

  TransactionList(this._transactions, this._removeTransaction, this._editTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: _transactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No Transaction is added yet",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  //margin: EdgeInsets.all(30),
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          width: 90,
                          margin: EdgeInsets.all(10),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              "Rs ${_transactions[index].amount.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColorDark,
                                width: 2),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_transactions[index].title}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              DateFormat.yMEd()
                                  .format(_transactions[index].date),
                              style: TextStyle(color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit_outlined),
                              onPressed: () {
                                _editTransaction(context,_transactions[index].id);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_forever,
                              ),
                              onPressed: () {
                                _removeTransaction(_transactions[index].id);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
