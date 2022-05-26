import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:util/screens/game/baseG.dart';
import 'package:util/screens/game/ui_game/game_over_menu.dart';
import 'package:util/screens/game/ui_game/pause_button.dart';
import 'package:util/screens/game/ui_game/pause_menu_overlay.dart';

class MainSpaceGame extends StatelessWidget {
  const MainSpaceGame({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SpaceShooter _spaceShooter = SpaceShooter();
    return Scaffold(
      body: GameWidget(

          game: _spaceShooter,
        initialActiveOverlays: [PauseButton.pauseButtonId],
        overlayBuilderMap: {
            PauseButton.pauseButtonId:(context,SpaceShooter gameref)=>PauseButton(spaceShooter: gameref,),
          PauseMenu.pauseMenuId:(context,SpaceShooter gameref)=>PauseMenu(spaceShooter: gameref,),
          GameOverMenu.GameOverMenuId:(context,SpaceShooter gameref)=>GameOverMenu(spaceShooter: gameref,)
        },
      ),
    );
  }
}
