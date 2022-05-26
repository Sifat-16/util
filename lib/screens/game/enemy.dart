import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:util/screens/game/baseG.dart';
import 'package:util/screens/game/bullet.dart';
import 'package:util/screens/game/models/enemy_data.dart';
import 'package:util/screens/game/models/player.dart';
import 'package:util/screens/game/shooter.dart';
class Enemy extends SpriteComponent with HasGameRef<SpaceShooter>, HasHitboxes, Collidable{
  double speed = spaceships[currentChoice].speed+50;
  final EnemyData enemyData;
  Vector2 moveDirection = Vector2(0, 1);
  Random _random = Random();
  Enemy(
      Sprite? sprite,
      Vector2? position,
      Vector2? size, this.enemyData
      ):super(sprite: sprite, position: position, size: size){
    angle = pi*.5;

    if(true){
      moveDirection = getRandomDirection();
    }
  }

  Vector2 getRandomDirection(){
    return (Vector2.random(_random)-Vector2(0.5, -1)).normalized();
  }


  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    final shape = HitboxCircle(normalizedRadius: 0.6);
    //this.debugMode=true;
    addHitbox(shape);

  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if(other is Bullet||other is Player){
      this.removeFromParent();
      gameRef.audioManager.playSfx("laser.ogg");

      gameRef.children.whereType<Player>().forEach((element) {
        element.score+=1;
        if(element.score>highScore){
          highScore=element.score;
        }
      });

    }
  }

    @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    this.position += moveDirection*speed*dt;
    if(this.position.y>this.gameRef.size.y){
      removeFromParent();
    }else if((this.position.x<this.size.x/2)||(this.position.x>(this.gameRef.size.x-this.size.x/2))){
      moveDirection.x*=-1;
    }
  }
  @override
  void onRemove() {
    // TODO: implement onRemove
    super.onRemove();

  }




}