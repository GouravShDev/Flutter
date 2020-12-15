import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/edit_Transaction.dart';
import 'package:flutter/cupertino.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import 'widgets/new_transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Planner",
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'PlayFair',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  fontFamily: 'PTSans'),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'PTSans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: MyAppHome(),
    );
  }
}

class MyAppHome extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 1,
    //   amount: 99,
    //   title: "Transaction 1",
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 2,
    //   amount: 20,
    //   title: "Transaction 2",
    //   date: DateTime.now(),
    // )
  ];
  List<Transaction> get _recentTransaction{
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    Transaction newTranx = new Transaction(
        id: DateTime.now().toString(), title: title, amount: amount, date: date);
    setState(() {
      _transactions.add(newTranx);
    });
  }
  void _delTransaction(String id){
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _editTranasaction(BuildContext ctx, String id){
    Transaction editTx;
    // for(int i = 0; i < _transactions.length; i++){
    //   if(_transactions[i].id == id){
    //     editTx = _transactions[i];
    //     break;
    //   }
    // }
    editTx = _transactions.firstWhere((element) => element.id == id);
    if(editTx == null){
      print("$id");
      print("couldn't find the id");
      return;
    }
    _startEditTransaction(ctx, editTx);
  }
  void _editingTx(Transaction trx,String title, double amount, DateTime date){
    setState(() {
      trx.title =title;
      trx.date = date;
      trx.amount = amount;
    });


  }
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }
  void _startEditTransaction(BuildContext ctx, Transaction tx){
    showModalBottomSheet(context: ctx,builder: (_) => EditTransaction(_editTranasaction, tx,_editingTx));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _startAddNewTransaction(context);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransaction),
            TransactionList(_transactions, _delTransaction,_editTranasaction),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Expense Planner"),
        actions: <Widget>[
          IconButton(
            color: Theme.of(context).primaryColorLight,
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 30,
              semanticLabel: "Add",
            ),
          ),
        ],
        centerTitle: true,
      ),
    );
  }
}
