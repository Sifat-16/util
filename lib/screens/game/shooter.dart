import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/particles.dart';
import 'package:flutter/widgets.dart';
import 'package:util/screens/game/enemy.dart';
import 'package:util/screens/game/models/player.dart';


class Player extends SpriteComponent with HasGameRef, HasHitboxes, Collidable{

  Vector2 moveDirection = Vector2.zero();
  double _speed = spaceships[currentChoice].speed;
  Random random = Random();

  int score=0;
  int health=100;


  Vector2 getRandomVector(){
    return Vector2.random(random)*500;
  }

  Player(
      Sprite? sprite,
      Vector2? position,
      Vector2? size
      ): super(sprite: sprite, position: position, size: size);


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
    if(other is Enemy){
      gameRef.camera.shake(intensity: 5);

      health-=10;
      if(health<0){
        health=0;
      }
    }
  }



  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

      this.position += moveDirection.normalized()*_speed*dt;
      this.position.clamp(Vector2.zero()+this.size/3, this.gameRef.size-this.size/3);




  }

  setMoveDirection(Vector2 newMoveDirection){
    moveDirection = newMoveDirection;
  }

  void reset(){
    this.score=0;
    this.health=100;
    this.position=gameRef.size / 2;

  }

}