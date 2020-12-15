import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class EditTransaction extends StatefulWidget {
  final Function editTrx;
  final Transaction transaction;
  final Function _postEdit;

  EditTransaction(this.editTrx, this.transaction, this._postEdit);

  @override
  _EditTransactionState createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    String title = titleController.text;
    double amount = 0;
    try{
      amount = double.parse(amountController.text);
    }on FormatException catch(e){
      print("No input was given in amount text field => $e");
    }
    widget._postEdit(
        widget.transaction,
        title.isEmpty ? widget.transaction.title : title,
        amount <= 0 ? widget.transaction.amount : amount,
        _selectedDate == null ? widget.transaction.date : _selectedDate);
    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        if (value != null) {
          _selectedDate = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: titleController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: widget.transaction.title,
          ),
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: amountController,
          onSubmitted: (_) {
            _submitData();
          },
          decoration: InputDecoration(
            labelText: widget.transaction.amount.toString(),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate == null
                  ? "Previous Date : ${DateFormat.yMd().format(widget.transaction.date)}"
                  : "Picked Date : ${DateFormat.yMd().format(_selectedDate)}",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            new InkWell(
              onTap: () {
                _openDatePicker();
              },
              child: new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Text(
                  "Choose Date",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        FlatButton(
            child: Text("Add Transaction"),
            onPressed: _submitData,
            color: Theme.of(context).primaryColorDark),
      ],
    );
  }
}
