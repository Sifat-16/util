import 'package:flutter/material.dart';
import 'package:util/database/credit_box.dart';
import 'package:util/models/loan&due/loan.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:util/screens/loan&due/widgets/loan_due_widget.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({Key? key}) : super(key: key);

  @override
  _LoanScreenState createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {

  bool paid=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(

        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            )
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Loan", style: TextStyle(color: Colors.black),),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(

              children: [

                Switch(
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.redAccent[100],
                    value: paid,
                    onChanged: (switched){
                  setState(() {
                    paid=!paid;
                  });
                }),
                Visibility(

                  child: Text("Unpaid", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  visible: !paid,

                ),
                Visibility(
                    child: Text("Paid", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  visible: paid,

                )
              ],
            ),
          )

        ],

      ),


      body: ValueListenableBuilder<Box<Credit>>(
        valueListenable: CreditBox.getCredits().listenable(),
        builder: (context, box, _){
          final loaner = paid==false? box.values.where((element) => element.type==-1&&!element.paid).toList().reversed.toList():box.values.where((element) => element.type==-1&&element.paid).toList().reversed.toList();


          return ListView.builder(
            itemCount: loaner.length,
            itemBuilder: (context, index){

              final item = loaner[index];


              return Dismissible(
                background: _containerBackground(item),
                secondaryBackground: _containerSecondaryBackground(item),
                key: UniqueKey(),
                onDismissed: (direction){
                    if(direction==DismissDirection.endToStart){
                      deleteCredit(item);
                    }else{
                      changePaidCredit(item);
                    }
                },
                child: ExpansionTile(
                  leading: Icon(Icons.circle),
                  //subtitle: Text(item.uid),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          item.name
                      ),
                      GestureDetector(
                        onTap: (){
                          showAmountAddDialog(context, TextEditingController(), TextEditingController(), item);
                        },
                        child: Icon(
                            Icons.add
                        ),
                      ),

                    ],

                  ),
                  /*trailing: GestureDetector(
                    onTap: (){
                        showAmountAddDialog(context, TextEditingController(), TextEditingController(), item);
                    },
                    child: Icon(
                        Icons.add
                    ),
                  ),*/
                  children: [
                    Container(
                      height: 180,
                      child: ValueListenableBuilder<Box<Amount>>(
                        valueListenable: CreditBox.getAmounts().listenable(),
                        builder: (context, box, _){

                          final amounts = box.values.where((element) => element.creditorUid==item.uid).toList();

                          return ListView.builder(
                              itemCount: amounts.length,
                              itemBuilder: (context, index){
                                final amnt = amounts[index];

                                return Dismissible(
                                  background: _containerBackgroundAmount(amnt),
                                  secondaryBackground: _containerSecondaryBackgroundAmount(amnt),
                                  onDismissed: (direction){
                                    if(direction==DismissDirection.startToEnd){
                                      changePaidAmount(amnt);
                                    }else{
                                      deleteAmount(amnt);
                                    }
                                  },

                                  key: UniqueKey(),
                                  child: ListTile(
                                    //subtitle: Text(amnt.creditorUid),
                                    leading: Icon(
                                      !amnt.paid ? Icons.circle:Icons.check_circle_outline,
                                      color: amnt.paid==true?Colors.lightGreenAccent:Colors.redAccent,

                                    ),
                                    title: Row(
                                      mainAxisAlignment:amnt.reason!.length!=0? MainAxisAlignment.spaceBetween:MainAxisAlignment.start,
                                      children: [
                                        Text("${amnt.reason}"),
                                        Text(amnt.amount.toString()),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                      ),
                    )
                  ],

                ),
              );
            },
          );
        },
      ),
    );
  }

  _containerBackground(Credit item){
    return Container(
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          !item.paid ? Icon(Icons.check, color: Colors.white,):Icon(Icons.radio_button_unchecked, color: Colors.white,),
          SizedBox(width: 5,),
          Text(!item.paid?"Paid":"Unpaid?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),


        ],
      ),
    );
  }
  _containerBackgroundAmount(Amount item){
    return Container(
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          !item.paid ? Icon(Icons.check, color: Colors.white,):Icon(Icons.radio_button_unchecked, color: Colors.white,),
          SizedBox(width: 5,),
          Text(!item.paid?"Paid":"Unpaid?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),


        ],
      ),
    );
  }
  _containerSecondaryBackground(Credit item){
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          SizedBox(width: 5,),
          Icon(Icons.delete_forever, color: Colors.white,)
        ],
      ),
    );
  }
  _containerSecondaryBackgroundAmount(Amount item){
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          SizedBox(width: 5,),
          Icon(Icons.delete_forever, color: Colors.white,)
        ],
      ),
    );
  }

}
