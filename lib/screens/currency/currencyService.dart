


import 'dart:convert';

import 'package:http/http.dart';
import 'package:util/models/currency/Currency.dart';

import 'currencyData.dart';





bool loadedCurrency=false;

 Future<Map<String, Currency>> getCurData() async{
  Response data = await get(Uri.parse("https://freecurrencyapi.net/api/v2/latest?apikey=756ef710-64e0-11ec-a952-134c4c3119af"));
  var maindata = jsonDecode(data.body);
  var it = maindata["data"].toString();

  base = maindata["query"]["base_currency"];


  var start=1;
  var end = it.length-1;
  List<String> lst = [];
  String s="";
  for(int i=start;i<end;i++){
    if(it[i]==','){
      lst.add(s);
      s="";
    }else if(it[i]!=" "){
      s+=it[i];
    }
  }


  Map<String,Currency>lhsp = Map();

  lst.forEach((element) async {
    String first = element.substring(0,3);
    String second = element.substring(4);

    double s = double.parse(second);

    late Currency c;
    //Response mv = await get(Uri.parse("https://restcountries.com/v3.1/currency/${first}"));
    //var dt = jsonDecode(mv.body);
    //if(mv.statusCode==200){

    //  c = Currency(first, s, Country(dt[0]["name"]["common"], dt[0]["cca2"]));
    //}else{
    c = Currency(first, s);
    //}


    lhsp[first]=c;

  });
  lhsp[base]=Currency(base, 1);


  return lhsp;

}


Future<List<Country>> getAllCountries() async{



   Response mv = await get(Uri.parse("https://restcountries.com/v3.1/all"));
   List<Country>countries=[];
   var data = jsonDecode(mv.body);

   Iterable it = data;

   it.forEach((element) {
     var cnc = "";
     if(element["currencies"]!=null){
       cnc = element["currencies"].toString().substring(1,4);

       countries.add(Country(name: element["name"]["common"], code: element["cca2"], currency: Currency(cnc, 0.0))..flag=element["flag"]);
     }

   });
   countries.sort((a,b)=>a.name.compareTo(b.name));

   return countries;


}


