
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:util/screens/game/enemy.dart';
import 'package:util/screens/game/models/enemy_data.dart';
import 'package:util/screens/game/models/player.dart';

class EnemyManager extends Component with HasGameRef{
  late Timer _timer;
  //SpriteSheet spriteSheet;
  Random random = Random();

  EnemyManager():super(){
    _timer=Timer(1-(currentChoice*.068), onTick: _spawnEnemy, repeat: true, autoStart: true);

  }


  static const List<EnemyData> enemyDataList = [EnemyData(
    killPoint: 1,
    speed: 200,
    id: 1,
    level: 1,
    hMove: false,
  ),
    EnemyData(
      killPoint: 2,
      speed: 200,
      id: 2,
      level: 1,
      hMove: true,
    ),
    EnemyData(
      killPoint: 4,
      speed: 200,
      id: 3,
      level: 1,
      hMove: true,
    ),
    EnemyData(
      killPoint: 4,
      speed: 200,
      id: 4,
      level: 1,
      hMove: false,
    ),
    EnemyData(
      killPoint: 6,
      speed: 250,
      id: 5,
      level: 2,
      hMove: true,
    ),



  ];


  _spawnEnemy(){
    Vector2 initialSize= Vector2(80, 80);
    Vector2 position = Vector2(random.nextDouble()*this.gameRef.size.x, 0);
    position.clamp(Vector2.zero()+initialSize/2, this.gameRef.size-initialSize/2);

    final enemyData = enemyDataList.elementAt(random.nextInt(enemyDataList.length));
    final sprite = Sprite(gameRef.images.fromCache("eship${enemyData.id}.png"));
    Enemy enemy= Enemy(sprite,
        position,
        initialSize,
        enemyData
    );

    enemy.anchor = Anchor.center;
    add(enemy);



  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    _timer.start();
  }

  @override
  void onRemove() {
    // TODO: implement onRemove
    super.onRemove();
    _timer.stop();
  }
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    _timer.update(dt);
  }

  void reset(){
    _timer.stop();
    _timer.start();
  }



}