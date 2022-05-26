import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:util/models/loan&due/loan.dart';
import 'package:util/service_widgets/datetime_to_date.dart';

class CreditBox{
  static Box<Credit> getCredits() => Hive.box("creditBox");
  static Box<Amount> getAmounts() => Hive.box("amountBox");
}

Future createCredit(String name, int importance, int type) async{

  final credit = Credit()
  ..name=name
  ..uid=UniqueKey().toString()
    ..dateToPay=null
  ..importance=importance
  ..type=type
  ..paid=false;

  print(credit.uid);
  final box = CreditBox.getCredits();
  await box.add(credit);


}

Future createAmount(String? reason, double amnt, String? payDate, String uid) async{

  final amount = Amount()
      ..reason=reason
      ..amount=amnt
      ..paid=false
      ..date=toDate(DateTime.now())
      ..payDate=payDate
      ..creditorUid=uid;

  final box = CreditBox.getAmounts();
  await box.add(amount);
  //addAmountToCredit(creditor, amount);

}

Future deleteAmount(Amount amount) async{
  amount.delete();
}

Future changePaidAmount(Amount amount) async{
  amount.paid=!amount.paid;
  amount.save();
}

Future deleteCredit(Credit credit) async{
  final box = CreditBox.getAmounts();
  box.values.forEach((element) {
    if(element.creditorUid==credit.uid){
      deleteAmount(element);
    }
  });
  credit.delete();
}

Future changePaidCredit(Credit credit) async{
  credit.paid=!credit.paid;
  credit.save();
}