import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:util/screens/game/audio/audio_manager.dart';
import 'package:util/screens/game/models/player.dart';
import 'package:util/screens/game/models/starting_module.dart';
import 'package:util/screens/game/shooter.dart';
import 'package:util/screens/game/speeds.dart';
import 'package:util/screens/game/ui_game/game_over_menu.dart';
import 'package:util/screens/game/ui_game/pause_button.dart';
import 'package:util/screens/game/ui_game/pause_menu_overlay.dart';

import 'bullet.dart';
import 'bullet_manager.dart';
import 'enemy.dart';
import 'enemy_manager.dart';

class SpaceShooter extends FlameGame with PanDetector, HasCollidables{


  Offset? _pointerStartPosition;
  Offset? _pointerCurrentPosition;
  final double joystickRadius = 60;
  late Player player;

  late BulletManager bulletManager;
  late EnemyManager enemyManager;

  late TextComponent playerScore;
  late TextComponent playerHealth;
  late final spriteForShooter;
  late final sps;
  late AudioManager audioManager;
 // late final spriteForEnemy;


  bool _isAlereadyLoaded=false;



  @override
  Future<void>? onLoad() async {
    if (!_isAlereadyLoaded) {
      await images.loadAll(["shooter.png", "eship1.png","eship2.png","eship3.png","eship4.png","eship5.png","spa1.png", "spa2.png","spa3.png","spa4.png","spa5.png","spa6.png","spa7.png","spa8.png","spa9.png","spa10.png","spa11.png","spa12.png"]);




      ParallaxComponent stars = await ParallaxComponent.load(
          [

            ParallaxImageData("dparab.png"),

          ],
        fill: LayerFill.width,
        repeat: ImageRepeat.repeat,
        baseVelocity: Vector2(0, -50),
        velocityMultiplierDelta: Vector2(0, 1.3)
      );
      add(stars);

      audioManager = AudioManager();

      add(audioManager);



      spriteForShooter = SpriteSheet.fromColumnsAndRows(
          columns: 2,
          rows: 12,
          image: images.fromCache("shooter.png")

      );

      sps = Sprite(
          images.fromCache(spaceships[currentChoice].assetPath)
      );

      print(currentChoice);

      player = Player(
        sps,

        this.canvasSize / 2,
        Vector2(70, 70),
      );

      player.anchor = Anchor.center;
      add(player);
      bulletManager = BulletManager(tm:1-(currentChoice*.065),
          spriteSheet: spriteForShooter, position: this.player.position);

      add(bulletManager);

      enemyManager = EnemyManager();
      add(enemyManager);

      playerScore = TextComponent(
        text: "Score: 0", position: Vector2(10, 25), textRenderer: TextPaint(
          style: TextStyle(
              color: Colors.white,
              fontSize: 16
          )
      ),
        anchor: Anchor.topLeft,

      );
      playerHealth = TextComponent(text: "Health: 100%",
          position: Vector2(size.x - 10, 25),
          textRenderer: TextPaint(
            style: TextStyle(
                color: Colors.white,
                fontSize: 16
            ),

          ),
          anchor: Anchor.topRight

      );


      playerScore.positionType = PositionType.viewport;
      playerHealth.positionType = PositionType.viewport;
      add(playerScore);
      add(playerHealth);
      _isAlereadyLoaded=true;
    }
  }





  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(size.x-110, 25, player.health.toDouble(), 20), Paint()..color =player.health>=80? Colors.green:player.health<80&&player.health>=50?Colors.lightGreenAccent:player.health<50&&player.health>=30?Colors.redAccent:Colors.red);
    super.render(canvas);


  }

  @override
  void onAttach() {
    audioManager.playBgm("space.wav");

    super.onAttach();
  }


  @override
  void onDetach(){
    audioManager.stopBgm();

    if(player.score>highScore){
      highScore=player.score;
    }

    super.onDetach();
  }


@override
  void onRemove() {
  if(player.score>highScore){
    highScore=player.score;
  }
    super.onRemove();
  }


  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    playerScore.text = "Score: ${player.score}";
    playerHealth.text = "Health: ${player.health}%";

    if(player.health<=0&&(!camera.shaking)){
      this.pauseEngine();
      this.overlays.remove(PauseButton.pauseButtonId);
      this.overlays.add(GameOverMenu.GameOverMenuId);
    }






  }

  @override
  void onPanDown(DragDownInfo info) {



  }
  @override
  void onPanStart(DragStartInfo info) {
    _pointerStartPosition = info.raw.globalPosition;
    _pointerCurrentPosition = info.raw.globalPosition;

  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    _pointerCurrentPosition = info.raw.globalPosition;
    var dt = _pointerCurrentPosition!-_pointerStartPosition!;

    if(dt.distance>10){
      player.setMoveDirection(Vector2(dt.dx, dt.dy));
    }else{
      player.setMoveDirection(Vector2.zero());
    }





  }

  @override
  void onPanEnd(DragEndInfo info) {
    _pointerStartPosition = null;
    _pointerCurrentPosition=null;
    player.setMoveDirection(Vector2.zero());


  }
  @override
  void onPanCancel() {
    _pointerStartPosition = null;
    _pointerCurrentPosition=null;
    player.setMoveDirection(Vector2.zero());

  }



  void reset(){
      player.reset();
      enemyManager.reset();

      enemyManager.children.whereType<Enemy>().forEach((element) {
        element.removeFromParent();
      });
      bulletManager.children.whereType<Bullet>().forEach((element) {
        element.removeFromParent();
      });


  }


  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (this.player.health > 0) {
          this.pauseEngine();
          this.overlays.remove(PauseButton.pauseButtonId);
          this.overlays.add(PauseMenu.pauseMenuId);
        }
        break;
    }
    super.lifecycleStateChange(state);
  }




}