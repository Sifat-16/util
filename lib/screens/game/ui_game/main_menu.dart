import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:util/screens/game/ads/rewardAds.dart';
import 'package:util/screens/game/models/player.dart';
import 'package:util/screens/game/models/starting_module.dart';
import 'package:util/screens/game/ui_game/main_game_file.dart';


class MainGameMenu extends StatefulWidget {
  const MainGameMenu({Key? key}) : super(key: key);

  @override
  State<MainGameMenu> createState() => _MainGameMenuState();
}

class _MainGameMenuState extends State<MainGameMenu> {

  int? sound=0;
  int? sfx=0;
  late SharedPreferences prefs;

  @override
  void initState(){

    pref().then((value){
      setState(() {
        prefs=value;



      });
      sound = prefs.getInt("game_bgm");
      sfx = prefs.getInt("game_sfx");

      int? selected = prefs.getInt("selected_spaceship");

      int? hs = prefs.getInt("high_score");
      int? cs = prefs.getInt("cash");
      int? lv = prefs.getInt("level");

      if(lv==null){
        prefs.setInt("level", level);
      }else{
        setState(() {
          level=lv;
        });
      }

      if(hs==null){
        prefs.setInt("high_score", highScore);
      }else{
        if(highScore>hs){
          prefs.setInt("high_score", highScore);
          if(highScore>=100&&highScore<200){
            setState(() {
              level=2;
            });
          }else if(highScore>=200&&highScore<300){
            setState(() {
              level=3;
            });
          }else if(highScore>=300&&highScore<400){
            setState(() {
              level=4;
            });
          }else if(highScore>=400&&highScore<500){
            setState(() {
              level=5;
            });
          }else if(highScore>=600&&highScore<700){
            setState(() {
              level=6;
            });
          }

          prefs.setInt("level", level);
        }else{
          setState(() {
            highScore=hs;
          });
        }

      }



      if(cs==null){
        prefs.setInt("cash", cash);
      }else{
        setState(() {
          cash=cs;
        });
      }

      if(selected==null){
        prefs.setInt("selected_spaceship", 0);
      }else{
        setState(() {

          currentChoice = selected;

        });
      }




      if(sound==null){
        setState(() {
          sound=1;
        });
        prefs.setInt("game_bgm", sound!);
      }

      if(sfx==null){
        setState(() {
          sfx=1;
        });
        prefs.setInt("game_sfx", sfx!);
      }

      setState(() {
        startingModule.backgroundMusic=sound!;
        startingModule.sfxMusic=sfx!;
      });

    });




    super.initState();
  }


  Future<SharedPreferences>pref() async{
    return await SharedPreferences.getInstance();
  }



  @override
  Widget build(BuildContext context){

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/space_back.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("High score: $highScore", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),),

                  Text("Level: $level(${highScore-(level-1)*100}%)", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                  Text("Cash: $cash", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),)
                ],
              ),

              CarouselSlider.builder(
                  itemCount: spaceships.length,
                  itemBuilder: (context, ind, realInd){
                        return Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(spaceships[ind].bulletPath),
                              Image.asset("assets/images/${spaceships[ind].assetPath}"),
                              Text(spaceships[ind].name, style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),),
                              Text("Acceleration: ${spaceships[ind].cost}", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("Speed: ${spaceships[ind].speed}", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),

                              spaceships[ind].level<=level?

                              ElevatedButton(onPressed:(){

                                setState(() {
                                  currentChoice=ind;
                                });
                                prefs.setInt("selected_spaceship", currentChoice);


                              }, child: Text("Select"),

                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(currentChoice==ind?Colors.grey:Colors.green)
                                ),
                              ):
                              ElevatedButton(onPressed:(){


                              }, child: Text("Level: ${spaceships[ind].level}"),

                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black54)
                                ),
                              )
                            ],
                          ),
                        );
                  },
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height*.5,
                      enableInfiniteScroll: false,
                      initialPage: currentChoice

                  )
              ),


              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Background Sound: ", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                      Switch(
                          trackColor: MaterialStateProperty.all<Color>(Colors.white),
                          inactiveThumbColor: Colors.red,
                          value: sound==1?true:false,
                          onChanged: (value){
                            setState(() {
                              if(sound==0){
                                sound=1;

                              }else{
                                sound=0;
                              }
                              startingModule.backgroundMusic = sound!;
                            });

                            prefs.setInt("game_bgm", sound!);
                          }
                      )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Special Effects Sound: ", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                      Switch(
                          trackColor: MaterialStateProperty.all<Color>(Colors.white),
                          inactiveThumbColor: Colors.red,
                          value: sfx==1?true:false,
                          onChanged: (value){
                            setState(() {
                              if(sfx==0){
                                sfx=1;
                              }else{
                                sfx=0;
                              }
                              startingModule.sfxMusic = sound!;
                            });
                            prefs.setInt("game_sfx", sfx!);
                          }
                      )
                    ],
                  ),
                ],
              ),


              ElevatedButton(onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainSpaceGame()));
              }, child: Text("Play")),

            ],
          ),
      ),

    );
  }





}
