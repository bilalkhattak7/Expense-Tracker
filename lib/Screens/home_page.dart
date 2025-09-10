import 'package:flutter/material.dart';

import 'add_expense.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
       title: Text("Expense Tracker" ,style: TextStyle(fontWeight: FontWeight.bold),),
       backgroundColor: Colors.blue,
     ),


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 720,
            height: 120,

            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(13.0),
            ),
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 30.0),
            child: Text("Total Balance" , style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 520,
                height: 120,

                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(13.0),
                ),
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 30.0),
                child: Text("Total Income" , style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              Container(
                width: 520,
                height: 120,

                decoration: BoxDecoration(

                  color: Colors.red,
                  borderRadius: BorderRadius.circular(13.0),
                ),
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 30.0),
                child: Text("Total Expenses" , style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(
         MaterialPageRoute(builder: (context) => AddExpense()),
        );

      },
      child: Icon(Icons.add),
      ),


    );
  }
}
