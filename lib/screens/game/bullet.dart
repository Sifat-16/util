

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:util/screens/game/enemy.dart';
import 'package:util/screens/game/models/player.dart';


class Bullet extends SpriteComponent with HasHitboxes, Collidable{

  double speed = spaceships[currentChoice].speed;
  Bullet(
      Sprite? sprite,
      Vector2? position,
      Vector2? size,
      ): super(sprite: sprite, position: position, size: size);



  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    final shape = HitboxCircle(normalizedRadius: 0.1);
    //this.debugMode=true;
    addHitbox(shape);
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);

    if(other is Enemy){
      this.removeFromParent();
    }
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    this.position += Vector2(0, -1)*speed*dt;
    if(this.position.y<0){
      removeFromParent();
    }
  }



}