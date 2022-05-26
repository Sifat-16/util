

import 'dart:convert';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';

import 'package:util/models/currency/Currency.dart';
import 'package:util/screens/currency/currencyData.dart';
import 'package:util/screens/currency/currencyService.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {

  String data="0";
  double data2 = 0;
  int dot=0;


  callBack(varString){
    setState(() {

      if(data=="0"&&varString=="0"){
        return;
      }
      if(varString=="."&&dot>0){
        return;
      }

      if(data=="0"&&varString!="."){
        data="";
        data2 = 0;
      }

      data+=varString;
      data2 = double.parse(data);
      if(varString=="."){
        dot++;
      }
    });
  }

  clearOne(){
    if(data=="0"){
      return;
    }
    if(data.length==1){
      setState(() {
        data="0";
        data2 = 0;
      });
      return;
    }
    setState(() {
      if(data[data.length-1]=='.'){
        dot--;
      }
      data = data.substring(0,data.length-1);
      data2 = double.parse(data);
    });
  }

  clearCallBack(){
    setState(() {
      data="0";
      dot=0;
      data2 = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text("Currency Converter", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: Column(
        children: [
          CustomFirstContainer(data:data, data2: data2,),
          CustomSecondContainer(callBack: callBack, clearAll: clearCallBack, clearOne: clearOne,),

        ],
      ),

    );
  }
}

class CustomFirstContainer extends StatefulWidget {
  CustomFirstContainer({Key? key, required this.data, required this.data2}) : super(key: key);

String data;
double data2;

  @override
  _CustomFirstContainerState createState() => _CustomFirstContainerState();
}

class _CustomFirstContainerState extends State<CustomFirstContainer> {

  late Future<Map<String, Currency>> curdata;
  Map<String,Currency> curMap=Map();
  Map<String, Currency>? cd;

  int from=0;
  int to=0;

  late String ans;
  late Future<List<Country>> countries;



  @override
  void initState() {
    // TODO: implement initState

    curdata = getCurData();
    countries = getAllCountries();

    curdata.then((value) {
      setState(() {
        curMap = value;
      });
    });



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.075, vertical: MediaQuery.of(context).size.height*0.008),
      height: MediaQuery.of(context).size.height*0.4,
      width: MediaQuery.of(context).size.width*1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<Map<String,Currency>>(
                    future: curdata,
                    builder:(context, snapshot){

                     // var cts = snapshot.data;

                      if(snapshot.hasData){
                        var items = snapshot.data;


                        return FutureBuilder<List<Country>>(
                          future: countries,

                          builder: (context, snapshot) {

                            if(snapshot.hasData){
                              var items = snapshot.data;
                              return TextButton(onPressed: (){
                                CustomDialogToCurrency(context, items!, 1);
                              }, child: Row(
                                children: [
                                  Text("${items![from].flag}", style: TextStyle(
                                    fontSize: 25
                                  ),),
                                  SizedBox(width: 10,),
                                  Text("${items[from].name}(${items[from].currency!.code})", style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.deepPurple
                                  ),),
                                ],
                              )
                              );
                            }else{
                              return Lottie.asset("assets/redan.json", height: 90, width: 90);
                            }



                          }
                        );
                      }else{
                        return Lottie.asset("assets/redan.json", height: 90, width: 90);
                      }


                    }
                )
                //Icon(Icons.keyboard_arrow_down)
              ],
            ),
          Text(widget.data, style: TextStyle(
            fontSize: 20
          ),),
          CircleAvatar(

            child: RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.compare_arrows)
            ),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Map<String,Currency>>(
                  future: curdata,
                  builder:(context, snapshot){



                    if(snapshot.hasData){
                      var items = snapshot.data;



                      return FutureBuilder<List<Country>>(
                        future: countries,

                        builder: (context, snapshot) {

                          if(snapshot.hasData){
                            var items = snapshot.data;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: (){
                                      CustomDialogToCurrency(context, items!, 2);
                                    }, child: Row(
                                  children: [
                                    Text("${items![to].flag}",style: TextStyle(
                                        fontSize: 25
                                    ),),
                                    SizedBox(width: 10,),
                                    Text("${items[to].name}(${items[to].currency!.code})", style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.indigo
                                    ),),
                                  ],
                                )
                                ),
                                SizedBox(height: 5,),
                                Text("${((widget.data2/curMap[items[from].currency!.code]!.value)*curMap[items[to].currency!.code]!.value).toStringAsFixed(3)}", style: TextStyle(
                                    fontSize: 20
                                ),),
                                //Text("result")
                              ],
                            );
                          }else{
                            return Lottie.asset("assets/redan.json", height: 90, width: 90);
                          }


                        }
                      );
                    }else{
                      return Lottie.asset("assets/redan.json", height: 90, width: 90);
                    }

                  }
              )
              //Icon(Icons.keyboard_arrow_down)
            ],
          ),

        ],
      ),
    );
  }

  CustomDialogToCurrency(BuildContext ctx, List<Country> lst, int num) {

    return AwesomeDialog(
        context: ctx,
        dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Select a Country',
      body: Container(

        height: MediaQuery.of(context).size.height*.7,
        width: double.maxFinite,
        child: ListView.builder(
            itemCount: lst.length,
              itemBuilder: (context, index){

              Country item = lst[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    color: Colors.lightGreen.withOpacity(0.1),
                    child: TextButton(
                      onPressed: (){
                        if(num==1){
                          setState(() {
                            from=index;
                          });
                        }else if(num==2){
                          setState(() {
                            to=index;
                          });
                        }
                        Navigator.pop(ctx);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           item.name.length==0?Text("${item.code}"):

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${item.flag}"),
                                SizedBox(width: 5,),
                                Text("${item.name.length<=15?item.name:item.name.substring(0,15)}", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                                  overflow: TextOverflow.clip,

                                )

                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
      )


    ).show();
  }
}


class CustomSecondContainer extends StatefulWidget {
  CustomSecondContainer({Key? key, required this.callBack, required this.clearAll, required this.clearOne}) : super(key: key);
  final Function callBack;
  final Function clearAll;
  final Function clearOne;
  @override
  _CustomSecondContainerState createState() => _CustomSecondContainerState();
}

class _CustomSecondContainerState extends State<CustomSecondContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.075, vertical: MediaQuery.of(context).size.height*0.008),
      height: MediaQuery.of(context).size.height*0.45,
      width: MediaQuery.of(context).size.width*1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: ()=>widget.callBack("7"),
                    child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("7", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.060),), height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
                GestureDetector(
                    onTap: ()=>widget.callBack("8"),
                    child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("8", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
                GestureDetector(
                    onTap: ()=>widget.callBack("9"),
                    child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("9", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
                GestureDetector(
                  onTap: ()=>widget.clearAll(),
                    child: CustomButton(backGround: Colors.red.withOpacity(0.15),widget: Text("C", style: TextStyle(color: Colors.red, fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: ()=>widget.callBack("4"),
                    child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("4", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
                GestureDetector(
                    onTap: ()=>widget.callBack("5"),
                    child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("5", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
                GestureDetector(
                    onTap: ()=>widget.callBack("6"),
                    child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("6", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
                GestureDetector(
                  onTap: ()=>widget.clearOne(),

                    child: CustomButton(backGround: Colors.cyanAccent.withOpacity(0.1),widget: Icon(Icons.backspace_outlined, color: Colors.blue, size: MediaQuery.of(context).size.width*0.060,),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: ()=>widget.callBack("1"),

                            child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("1", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
                        GestureDetector(
                          onTap: ()=>widget.callBack("2"),
                            child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("2", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
                        GestureDetector(
                          onTap: ()=>widget.callBack("3"),
                            child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("3", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: ()=>widget.callBack("0"),
                            child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18*2.1,)),
                        //CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text("5"),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,),
                        GestureDetector(
                          onTap: ()=>widget.callBack("."),
                            child: CustomButton(backGround: Colors.grey.withOpacity(0.1),widget: Text(".", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.060),),height: MediaQuery.of(context).size.height*0.09, width: MediaQuery.of(context).size.width*0.18,)),
                      ],
                    ),

                  ],
                ),
                GestureDetector(
                  onTap: (){
                    //getCurrencyData();
                    //getCurData();
                  },
                    child: CustomButton(backGround: Colors.lightGreenAccent.withOpacity(0.15),widget: Icon(Icons.done, color: Colors.green,),height: MediaQuery.of(context).size.height*0.09*2.1, width: MediaQuery.of(context).size.width*0.18,)),
              ],
            )

          ],
      ),
    );
  }
}
class CustomButton extends StatefulWidget {
  CustomButton({Key? key, required this.backGround, required this.widget, required this.height, required this.width}) : super(key: key);
  Color backGround;
  Widget widget;
  double height;
  double width;
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backGround,
        borderRadius: BorderRadius.circular(10)


      ),
      child: Center(
        child: widget.widget,
      ),
    );
  }
}



