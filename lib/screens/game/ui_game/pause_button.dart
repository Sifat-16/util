import 'package:flutter/material.dart';
import 'package:util/screens/game/baseG.dart';
import 'package:util/screens/game/ui_game/pause_menu_overlay.dart';

class PauseButton extends StatelessWidget {
  static const String pauseButtonId="pauseButton";
  final SpaceShooter spaceShooter;
  const PauseButton({Key? key, required this.spaceShooter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,

      child: Container(
        margin: EdgeInsets.only(top: 45),
        child: TextButton(
          onPressed: (){
              spaceShooter.pauseEngine();
              spaceShooter.overlays.add(PauseMenu.pauseMenuId);
              spaceShooter.overlays.remove(pauseButtonId);
          },
          child: Icon(Icons.pause, color: Colors.white,),
        ),
      ),
    );
  }
}
