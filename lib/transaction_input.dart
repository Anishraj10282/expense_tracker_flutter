import "package:flutter/material.dart";
import "package:intl/intl.dart";

class TransactionInput extends StatefulWidget {
  Function addTx;

  TransactionInput(this.addTx);

  @override
  TransactionInputState createState() => TransactionInputState();
}

class TransactionInputState extends State<TransactionInput> {
  String titleInput;
  String amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectDate;

  void submitData() {
    final titleText = titleController.text;
    final amountText = double.parse(amountController.text);

    if (titleText.isEmpty || amountText <= 0 || selectDate==null) {
      return;
    }

    widget.addTx(titleText, amountText, selectDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectDate = pickedDate;
      });

      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onChanged: (value) {
                  titleInput = value;
                },
                onSubmitted: (_) => submitData,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData,
              ),
              Container(
                  height: 70,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Expanded(child:Text(selectDate==null?'No Date Chosen':"Picked Date:${DateFormat.yMMMd().format(selectDate)}")),
                    new Builder(
                        builder: (context) => new FlatButton(
                            onPressed: _presentDatePicker,
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            )))
                  ])),
              RaisedButton(
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: submitData),
            ],
          ),
        ));
  }
}
