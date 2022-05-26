import 'package:flutter/material.dart';
import 'package:util/screens/game/baseG.dart';
import 'package:util/screens/game/ui_game/main_menu.dart';
import 'package:util/screens/game/ui_game/pause_button.dart';

class GameOverMenu extends StatelessWidget {
  static const String GameOverMenuId ="GameOverMenuId";
  final SpaceShooter spaceShooter;
  const GameOverMenu({Key? key, required this.spaceShooter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Game Over", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),),

          ElevatedButton(onPressed: (){
            //spaceShooter.resumeEngine();
            spaceShooter.overlays.remove(GameOverMenuId);
            spaceShooter.overlays.add(PauseButton.pauseButtonId);
            spaceShooter.reset();
            spaceShooter.resumeEngine();

          }, child: Text("Restart"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
            ),
          ),

          ElevatedButton(onPressed: (){
            spaceShooter.overlays.remove(GameOverMenuId);
            spaceShooter.reset();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainGameMenu()));
          }, child: Text("Exit"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
          ),
          ),

        ],
      ),
    );
  }
}
