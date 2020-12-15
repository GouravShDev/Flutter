import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrx;

  NewTransaction(this.addTrx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);
    if (amount <= 0 || title.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTrx(title, amount, _selectedDate);
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
            labelText: "Title",
          ),
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: amountController,
          onSubmitted: (_) {
            _submitData();
          },
          decoration: InputDecoration(
            labelText: "Amount",
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
                  ? " No Date Selected Yet : "
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
