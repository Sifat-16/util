
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:util/screens/game/baseG.dart';
import 'package:util/screens/game/enemy.dart';
import 'package:util/screens/game/models/player.dart';

import 'bullet.dart';

class BulletManager extends Component with HasGameRef<SpaceShooter>{
  late Timer timer;
  double tm;
  SpriteSheet spriteSheet;
  Vector2 position;
  Random random = Random();



  BulletManager({required this.tm,required this.spriteSheet, required this.position}):super(){
    timer=Timer(tm, onTick: _spawnBullet, repeat: true, autoStart: true);

  }




  _spawnBullet(){
    Vector2 initialSize= Vector2(80, 80);
    //Vector2 position = Vector2(random.nextDouble()*this.gameRef.size.x, 0);
    position.clamp(Vector2.zero()+initialSize/3, this.gameRef.size-initialSize/3);

    Bullet bullet= Bullet(this.spriteSheet.getSpriteById(spaceships[currentChoice].bulletId),
        position,
        initialSize);
    bullet.anchor = Anchor.center;
    add(bullet);





  }


  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    timer.start();
  }


  @override
  void onRemove() {
    // TODO: implement onRemove
    super.onRemove();
    timer.stop();
  }
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    timer.update(dt);
  }
}