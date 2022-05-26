import 'package:flutter/material.dart';
import 'package:util/screens/game/baseG.dart';
import 'package:util/screens/game/ui_game/main_menu.dart';
import 'package:util/screens/game/ui_game/pause_button.dart';

class PauseMenu extends StatelessWidget {
  static const String pauseMenuId = "pauseMenuId";
  final SpaceShooter spaceShooter;
  const PauseMenu({Key? key, required this.spaceShooter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
              spaceShooter.resumeEngine();
              spaceShooter.overlays.add(PauseButton.pauseButtonId);
              spaceShooter.overlays.remove(pauseMenuId);
          }, child: Text("Resume"),

          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
          ),
          ),
          ElevatedButton(onPressed: (){
            //spaceShooter.resumeEngine();
            spaceShooter.overlays.remove(pauseMenuId);
            spaceShooter.overlays.add(PauseButton.pauseButtonId);
            spaceShooter.reset();
            spaceShooter.resumeEngine();

          }, child: Text("Restart")),
          ElevatedButton(onPressed: (){
            spaceShooter.overlays.remove(pauseMenuId);
            spaceShooter.reset();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainGameMenu()));
          }, child: Text("Exit"),
            style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
    ),),

        ],
      ),
    );
  }
}
