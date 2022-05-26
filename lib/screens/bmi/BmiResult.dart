import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BmiResult extends StatelessWidget {
  BmiResult({Key? key, required this.bmi}) : super(key: key);

  List<double> bmi;
  String result="";
  int pos=0;


  @override
  Widget build(BuildContext context) {

    if(bmi[0]<18.5){
      result = "Underweight";
      pos=0;
    }else if(bmi[0]>=18.5&&bmi[0]<25){
      result = "Normal weight";
      pos=1;
    }else if(bmi[0]>=25&&bmi[0]<30){
      result = "Pre-obesity";
      pos=2;
    }else if(bmi[0]>=30&&bmi[0]<35){
      result = "Obesity-class I";
      pos=3;
    }else if(bmi[0]>=35&&bmi[0]<40){
      result = "Obesity-class II";
      pos=3;
    }else{
      result = "Obesity-class III";
      pos=3;
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        title: Text("Back", style: TextStyle(
          color: Colors.black,
        ),),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),

      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Your", style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width*.1
              ),),
              SizedBox(width: 10,),
              Text("Summary", style: TextStyle(
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width*.1
              ),),
            ],
          ),

          customBmiCard(context),

          Text("Healthy BMI range: 18.5 kg/m\u00B2 - 24.9 kg/m\u00B2", style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.bold
          ),),
          Text("Ponderal index: ${bmi[3].toStringAsFixed(2)} kg/m\u00B3", style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.bold
          ),),

          IconButton(onPressed: (){

          },
              icon: Icon(Icons.screenshot, color: Colors.blue,)

          )

        ],
      ),

    );
  }

  Widget customBmiCard(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height*.5,
      width: MediaQuery.of(context).size.width*.8,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow:[
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],

      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Text("Your BMI is", style: TextStyle(
                color: Colors.deepPurpleAccent.withOpacity(0.9),
                fontSize: MediaQuery.of(context).size.width*.08
            ),),

            Text("${bmi[0].toStringAsFixed(2)}", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: MediaQuery.of(context).size.width*.12
            ),),
            Text("kg/m\u00B2", style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
            Container(
              height: 20,

              width: MediaQuery.of(context).size.width*.7,
              //color: Colors.red,

              child: CustomPaint(
                foregroundPainter: LinePainter(pos),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You are in ", style: TextStyle(
                    color: Colors.deepPurple
                ),),
                Text("${result}", style: TextStyle(
                    color: pos==0?Colors.red:pos==1?Colors.green:pos==2?Colors.redAccent:Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),)
              ],
            ),

            Text("Healthy weight : ${bmi[1].toStringAsFixed(2)} kgs - ${bmi[2].toStringAsFixed(2)} kgs", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple
            ),)

          ]
      ),

    );
  }

}

class LinePainter extends CustomPainter{
  final pos;

  LinePainter(this.pos);


  @override
  void paint(Canvas canvas, Size size) {

      final paint = Paint();
      paint.strokeWidth=10;
      paint.strokeCap=StrokeCap.butt;
      paint.color = Colors.yellowAccent;

      canvas.drawLine(
          Offset(size.width*(1/6), size.height*(1/2)),
          Offset(size.width*(2/6), size.height*(1/2)),

          paint
      );
      canvas.drawLine(
          Offset(size.width*(2/6), size.height*(1/2)),
          Offset(size.width*(3/6), size.height*(1/2)),

          paint
          ..color=Colors.green
          ..strokeCap=StrokeCap.butt
      );
      canvas.drawLine(
          Offset(size.width*(3/6), size.height*(1/2)),
          Offset(size.width*(4/6), size.height*(1/2)),

          paint
            ..color=Colors.redAccent.withOpacity(.7)
            ..strokeCap=StrokeCap.butt
      );
      canvas.drawLine(
          Offset(size.width*(4/6), size.height*(1/2)),
          Offset(size.width*(5/6), size.height*(1/2)),

          paint
            ..color=Colors.red
            ..strokeCap=StrokeCap.butt
      );

      /*canvas.drawLine(
          Offset(size.width*2.45/6, size.height*(1/2)),
          Offset(size.width*2.55/6, size.height*(1/2)),
          paint
            ..color=Colors.black


      );*/
      canvas.drawRect(Rect.fromLTWH(size.width*(1+pos+.45)/6, 0, size.width*.02, size.height),
          paint
          ..color=pos==0?Colors.yellowAccent:pos==1?Colors.green:pos==1?Colors.redAccent.withOpacity(0.7):Colors.red

      );

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}
