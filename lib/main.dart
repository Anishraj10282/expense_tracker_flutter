import "package:flutter/material.dart";
import "./transaction.dart";
import "./transaction_input.dart";
import "./transaction_list.dart";
import "./chart.dart";
import "package:intl/intl.dart";



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget
{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  final List<Transaction> transaction = [
    /*Transaction(id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now(),),
    Transaction(id: 't2', title: 'Grocery Weeks', amount: 79.00, date: DateTime.now(),),
    Transaction(id: 't3', title: 'New Toothbrush', amount: 10.00, date: DateTime.now(),),
    Transaction(id: 't4', title: 'New Clothes', amount: 80.00, date: DateTime.now(),),*/
  ];

  List<Transaction> get _recentTransactions{
    return transaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days:7)));
    }).toList();
  }

  void _addNewTransaction(String txtitle, double txamount, DateTime selectDate)
  {
    final newTx = Transaction(id:DateTime.now().toString(),title:txtitle,amount:txamount, date:selectDate);

    setState(() {
      transaction.add(newTx);
  });
  }
  void _deleteTransaction(String id)
  {
    setState(() {
      transaction.removeWhere((element) => element.id == id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple[300],
        accentColor: Colors.purple[500],
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(title:TextStyle(fontFamily:'OpenSans'),button: TextStyle(color:Colors.white)),
        appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20,fontWeight: FontWeight.bold)))

      ),
      title: "Expense Tracker",
      home: Builder(builder:(context)=>Scaffold(
          appBar: AppBar(
            title: Text("Expense Tracker",),
            actions: [IconButton(icon:Icon(Icons.add), onPressed:(){
              showModalBottomSheet<void>(context: context, builder: (BuildContext bCtx)
              {
                return TransactionInput (_addNewTransaction);
              });
            }),
          ]),
          body: SingleChildScrollView(child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                    Chart(_recentTransactions),
                TransactionList(transaction,_deleteTransaction),
              ])),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       floatingActionButton:Builder(builder:(context)=> FloatingActionButton( child: Icon(Icons.add), onPressed:(){
         showModalBottomSheet<void>(context: context, builder: (context)
         {
           return TransactionInput(_addNewTransaction);
         });
       },),
      ))));
  }
}
