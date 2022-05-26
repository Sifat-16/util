

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:util/database/credit_box.dart';
import 'package:util/models/loan&due/loan.dart';
import 'package:util/service_widgets/datetime_to_date.dart';

showCreditProfile(BuildContext context, TextEditingController namec, int page, int selected){

  bool deletetask=namec.text.length==0?false:true;

  bool errortextenabled=false;


  return AwesomeDialog(
      context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.NO_HEADER,
    body: StatefulBuilder(
      builder: (context, setState){
        return Column(
          children: [
            Text("Create Credit Profile"),
            SizedBox(height: 10,),
            TextField(

              controller: namec,
              onChanged: (value){
                if(value.length>0){
                  setState((){
                    errortextenabled=false;
                    deletetask=true;
                  });
                }else{
                  setState((){
                    deletetask=false;
                  });
                }
              },
              decoration: InputDecoration(
                  errorText: errortextenabled?"Must input task":null,

                  labelText: "Loaner",
                  suffixIcon: !deletetask && namec.text.length==0 ? Icon(Icons.edit, size: 15,):GestureDetector(
                    child: Icon(Icons.delete, size: 15,),
                    onTap: (){
                      setState((){
                        deletetask=false;
                        namec.clear();
                      });

                    },
                  ),
                  border: OutlineInputBorder(

                  )

              ),
            ),
            SizedBox(height: 10,),

            SizedBox(height: 10,),

            Text("Priority"),
            Column(
              children: [
                Switch(
                  inactiveThumbColor: Colors.blue,
                    inactiveTrackColor: Colors.blueAccent[100],
                    activeColor: Colors.red,
                    activeTrackColor: Colors.redAccent[100],
                    value: selected==0?false:true,
                    onChanged: (std){
                      setState((){
                        if(selected==0){
                          selected=1;
                        }else{
                          selected=0;
                        }
                      });
                    }
                ),
                Visibility(
                    visible: selected==0?true:false,
                    child: Text("Low", style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                Visibility(
                    visible: selected==1?true:false,
                    child: Text("High", style: TextStyle(fontWeight: FontWeight.bold),)
                )
              ],
            ),

            TextButton(
                onPressed: (){
                  if(namec.text.length==0){
                    setState((){
                      errortextenabled=true;
                    });
                  }else{

                    page==0?createCredit(namec.text, selected, -1):createCredit(namec.text, selected, 1);

                    Navigator.pop(context);
                  }
                },
                child: Text("Add Profile")
            )
          ],
        );
      },
    )

  )..show();
}

showAmountAddDialog(BuildContext context, TextEditingController reason, TextEditingController amount, Credit credit){
  bool deleteamount=amount.text.length==0?false:true;
  bool deletereason=reason.text.length==0?false:true;
  bool errortextenabled=false;
  bool vis=false;

   return AwesomeDialog(
       context: context,
        animType: AnimType.SCALE,
     dialogType: DialogType.NO_HEADER,
     body: StatefulBuilder(
       builder: (context, setState){
         return Column(
           children: [
             Text("Add Amount"),
             SizedBox(height: 10,),
             Visibility(
               visible: vis,
                 child:TextField(

                   controller: reason,
                   onChanged: (value){
                     if(value.length>0){
                       setState((){

                         deletereason=true;
                       });
                     }else{
                       setState((){
                         deletereason=false;
                       });
                     }
                   },
                   decoration: InputDecoration(


                       labelText: "Reason",
                       suffixIcon: !deletereason && reason.text.length==0 ? Icon(Icons.edit, size: 15,):GestureDetector(
                         child: Icon(Icons.delete, size: 15,),
                         onTap: (){
                           setState((){
                             deletereason=false;
                             reason.clear();
                           });

                         },
                       ),
                       border: OutlineInputBorder(

                       )

                   ),
                 ),
             ),
             Visibility(
               visible: !vis,
                 child: TextButton(onPressed: () {
                   setState((){
                     vis=!vis;
                   });
                 },
                 child: Text("Add Reason?"),
                 )
             ),
             SizedBox(height:10),
             TextField(
                keyboardType:TextInputType.number,
               controller: amount,
               onChanged: (value){
                 if(value.length>0){
                   setState((){
                     errortextenabled=false;
                     deleteamount=true;
                   });
                 }else{
                   setState((){
                     deleteamount=false;
                   });
                 }
               },
               decoration: InputDecoration(
                   errorText: errortextenabled?"Must input amount":null,

                   labelText: "Amount",
                   suffixIcon: !deleteamount && amount.text.length==0 ? Icon(Icons.edit, size: 15,):GestureDetector(
                     child: Icon(Icons.delete, size: 15,),
                     onTap: (){
                       setState((){
                         deleteamount=false;
                         amount.clear();
                       });

                     },
                   ),
                   border: OutlineInputBorder(

                   )

               ),
             ),

             SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 TextButton(
                     onPressed: (){
                       if(amount.text.length==0){
                         setState((){
                           errortextenabled=true;
                         });
                       }else{

                        createAmount(reason.text, double.parse(amount.text), null, credit.uid);
                        amount.clear();
                        reason.clear();

                       }
                     },
                     child: Text("Add another")
                 ),
                 TextButton(
                     onPressed: (){
                       if(amount.text.length==0){
                         setState((){
                           errortextenabled=true;
                         });
                       }else{

                         createAmount(reason.text, double.parse(amount.text), null, credit.uid);
                         amount.clear();
                         reason.clear();
                         Navigator.pop(context);


                       }
                     },
                     child: Text("Add")
                 ),
               ],
             )

           ],
         );
       },
     )
   )..show();
}