import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:util/screens/bmi/BmiResult.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {

  bool activeBoy=true;

  int currentHeight = 172;
  int currentWeight = 90;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.grey[100],
        title: Text("Health Tracker", style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
        elevation: 0,
      ),

      body: Container(
        //margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("BMI", style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height*.05
                  ),),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Calculator", style: TextStyle(
                    color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height*.05
                  ),),
                ],
              ),
            Text("Body mass index (BMI) is a measurement of body fat based on height and weight that applies to adult men and women."),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  GestureDetector(

                    onTap: (){
                      if(!activeBoy){
                        setState(() {
                          activeBoy=true;
                          currentHeight=172;
                          currentWeight=90;
                        });
                      }
                    },

                      child: customRoundedButton("assets/boy.json", activeBoy, "Male")
                  ),
                  GestureDetector(
                    onTap: (){
                      if(activeBoy){
                        setState(() {
                          activeBoy=false;
                          currentHeight=162;
                          currentWeight=60;
                        });
                      }
                    },
                      child: customRoundedButton("assets/girl.json", !activeBoy, "Female")),


              ],
            ),
            scrollerRow("assets/height.json", "Height (cm)", currentHeight, 0),
            scrollerRow("assets/weight.json", "Weight (kg)", currentWeight, 1),

            ElevatedButton(onPressed: (){

              double bmi = (currentWeight/(currentHeight*currentHeight))*10000;

              double idealShrt = 18.5*(currentHeight*currentHeight)/10000;
              double idealUp = 24.9*(currentHeight*currentHeight)/10000;

              double ponderalIndex = bmi/currentHeight*100;

              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BmiResult(bmi: [bmi, idealShrt, idealUp, ponderalIndex],)));

            }, child: Text("Calculate Your BMI ->"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple)
            ),
            ),
          ],
        ),
      ),

    );
  }

  Widget customRoundedButton(String path, bool active, String gender){
    return Column(

      children: [
        Container(

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(5, 5),
                  blurRadius: 15,
                  spreadRadius: 1
              ),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 15,
                  spreadRadius: 1
              )
            ]

          ),
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: MediaQuery.of(context).size.width*.22,
            child: Stack(children: [
              Lottie.asset(path, fit: BoxFit.cover),
              CircleAvatar(
                backgroundColor: !active?Colors.transparent.withAlpha(40):Colors.transparent,
                radius: MediaQuery.of(context).size.width*.22,

              ),

            ]),

          ),
        ),
        SizedBox(height: 10,),
        Text(gender, style: TextStyle(
          color: active?Colors.deepPurple:Colors.grey[500],
          fontWeight: FontWeight.bold
        ),)
      ],
    );
  }

  Widget scrollerRow(String path, String text, int selected, int horw){
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(1, 1),
              blurRadius: 10,
              spreadRadius: 1
          ),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: 10,
              spreadRadius: 1
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 10,),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: MediaQuery.of(context).size.height*.09,
                  width: MediaQuery.of(context).size.width*.18,
                  child: Lottie.asset(path, fit: BoxFit.cover),
                ),
              ),
              Text(text, style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Container(

              decoration: BoxDecoration(
                color: Colors.orangeAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)

              ),
              child: NumberPicker(
                itemWidth: MediaQuery.of(context).size.width*.15,
                axis: Axis.horizontal,
                  minValue: 0,
                  maxValue: 500,
                  value: selected,
                  onChanged: (value){
                        setState(() {
                          selected=value;
                          if(horw==0){
                            currentHeight=value;
                          }else{
                            currentWeight=value;
                          }
                        });
                  },
                /*decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black26),
                ),*/
                //haptics: true,
              ),
            ),
          ),



        ],
      ),
    );
  }
}


