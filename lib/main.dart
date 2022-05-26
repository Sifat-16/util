import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:util/models/loan&due/loan.dart';
import 'package:util/models/task/task.dart';
import 'package:util/screens/bmi/BmiCalculator.dart';
import 'package:util/screens/currency/CurrencyScreen.dart';
import 'package:util/screens/game/baseG.dart';
import 'package:util/screens/game/ui_game/main_menu.dart';
import 'package:util/screens/instagram_video_downloader/InstaGramVideoDownloader.dart';
import 'package:util/screens/loan&due/loan_due_screen.dart';
import 'package:util/screens/onboarding/OnboardingScreen.dart';
import 'package:util/screens/task/task_screen.dart';
import 'package:util/screens/weather/weather_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:util/screens/youtube_video_downloader/YoutubeScreen.dart';
import 'package:util/screens/youtube_video_downloader/YoutubeVideoDownloader.dart';

int? isViewed;
int? isVtask;

Future main() async{

 // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

 /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark
  ));*/

  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(CreditAdapter());
  Hive.registerAdapter(AmountAdapter());
  await Hive.openBox<Task>("taskBox");
  await Hive.openBox<Credit>("creditBox");
  await Hive.openBox<Amount>("amountBox");

  SharedPreferences prefs = await SharedPreferences.getInstance();


  isViewed = prefs.getInt("onBoard");
  isVtask = prefs.getInt("isVtask");




  await FlutterDownloader.initialize(
    debug: true
  );

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white
      ),
      home: isViewed!=0?OnboardingScreen():MyHomeScreen(),
      //home: OnboardingScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(


        title: Center(
          child: Stack(

            children: [
              Lottie.asset("assets/cuban.json",
                  height: MediaQuery.of(context).size.height*.13,
                  width: MediaQuery.of(context).size.width*.25
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*.06,
                child: Text("Utility",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,

                    fontSize: 30,
                    letterSpacing: 2
                ),
                ),
              ),


            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:  Column(
        children: [
          Expanded(
            child: GridView.count(


                    crossAxisCount: 2,
                    children: [

                      customChilds("Task", TaskScreen(), "assets/taan.json"),
                      customChilds("Weather", Weather(),"assets/wean.json"),

                      //customChilds("Loan & Due", LoanDue(),"assets/loan.json"),


                      customChilds("Currency", CurrencyScreen(), "assets/exan.json"),

                      customChilds("Youtube Video Downloader", YoutubeVideo(), "assets/yuan.json"),

                      customChilds("Shoot-Escape", MainGameMenu(), "assets/spacenscape.json"),

                      //customChilds("Instagram V Downloader", InstaDownloader(), "assets/yuan.json"),
                      customChilds("Bmi Calculator", BmiCalculator(), "assets/bmi2.json")

                    ],


                ),
          ),

          Lottie.asset("assets/tree.json",
          height: MediaQuery.of(context).size.height*.1,
            fit: BoxFit.cover
          )

          

        ],
      ),


    );
  }

  Widget customChilds(String title, StatefulWidget wid, String path){
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: MediaQuery.of(context).size.height*.18,
        width: MediaQuery.of(context).size.width*.32,
          decoration: BoxDecoration(



            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
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

        child: TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>wid));
        },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                  Lottie.asset(path,
                    height: MediaQuery.of(context).size.height*.1,
                    width: MediaQuery.of(context).size.width*.25,
                    fit: BoxFit.fill,),
                Text(title, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),)

              ],
            )
        ),
      ),
    );
  }

}

