import "package:flutter/material.dart";
import "./transaction.dart";
import "package:intl/intl.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height:550,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(margin:EdgeInsets.all(10),elevation: 5,child:ListTile(
              leading:CircleAvatar(radius:30, backgroundColor:Theme.of(context).accentColor,child:Padding(padding:EdgeInsets.all(6),child:FittedBox(child:Text("Rs.${transactions[index].amount}", style: TextStyle(color:Colors.white,),)),
              )),
            title:Text(transactions[index].title, style:Theme.of(context).textTheme.headline6,),
            subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
            trailing: IconButton(icon:Icon(Icons.delete,color:Colors.red[200]),onPressed:(){deleteTx(transactions[index].id);},),));
          },
          itemCount: transactions.length,
        ));
  }
}
