import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:util/main.dart';



class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
          pages: [
              PageViewModel(
                titleWidget: Text("\nUtility", style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width*.1,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blueGrey
                ),),
                //body: "\"We are here to ease your hassle\"",
                bodyWidget: Column(

                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.15,),
                    Center(
                      child: Lottie.asset("assets/welan.json"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.2,),
                    Text("\"We are here to ease your hassle\"", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width*.05
                    ),)
                  ],
                ),


              ),
            PageViewModel(
              titleWidget: Text("\nManage your daily tasks\n", style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width*.07,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,

              ),),
              //body: "",
              bodyWidget: Column(
                children: [
                  Center(
                    child: Lottie.asset("assets/taonan.json"),

                  ),
                  Text("With our interactive Task editor",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width*.05
                  ),)
                ],
              )
            ),
            PageViewModel(
              titleWidget: Text("\nStay updated with Weather stats", style: TextStyle(
                fontSize: MediaQuery.of(context).size.width*.06,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),),
              bodyWidget: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*.09,),
                  Center(
                    child: Lottie.asset("assets/wetan.json"),


                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.09,),
                  Text("With 83% accuracy rate", style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),)

                ],
              )
            ),

            PageViewModel(
                titleWidget: Text("\nUpdated Exchange Rates", style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width*.06,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),),
                bodyWidget: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.09,),
                    Center(
                      child: Image.asset("assets/currencyonboard.png"),


                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.09,),
                    Text("With 2 hours of update frequency", style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),)

                  ],
                )
            ),

            PageViewModel(
                titleWidget: Text("\nDownload your favourite youtube videos", style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width*.05,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),),
                bodyWidget: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.09,),
                    Center(
                      child: Image.asset("assets/youtubeonboard.png"),


                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.09,),
                    Text("For Free!!!", style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),)

                  ],
                )
            ),



            PageViewModel(
              title: "\nLet's Roll",
              bodyWidget: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*.15,),
                  Center(
                    child: Lottie.asset("assets/rollan.json"),


                  ),
                ],
              ),
              decoration: PageDecoration(
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                  color: Colors.black87
                )
              )
            ),

          ],
          done: Text("Ready"),
          onDone: ()async{

                int isV = 0;
                SharedPreferences preferences = await SharedPreferences.getInstance();

                await preferences.setInt("onBoard", isV);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_)=>MyHomeScreen())
                );
          },
          next: Icon(Icons.arrow_right_alt),

          dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: Colors.greenAccent,
              color: Colors.grey.withOpacity(0.6),
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
              )
          ),


        )
    );
  }
}
