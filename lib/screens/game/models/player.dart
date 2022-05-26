class SpaceShip{
  final String name;

  final int cost;

  final double speed;


  final int spriteId;

  final int bulletId;

  final String bulletPath;


  final String assetPath;

  final int level;

  SpaceShip( {
    required this.bulletId,
    required this.bulletPath,
    required this.name,
    required this.cost,
    required this.speed,
    required this.spriteId,
    required this.assetPath,
    required this.level,
  });
}


int currentChoice = 0;

int highScore=0;
int cash=0;
int level=1;


List<SpaceShip> spaceships = [

  SpaceShip(
      name: 'Alice',
      cost: 10,
      speed: 200,
      spriteId: 18,
      assetPath: 'spa10.png',
      level: 1,
      bulletId: 19,
      bulletPath: 'assets/images/bl10.png'
  ),
  SpaceShip(
      name: 'Arizona',
      cost: 15,
      speed: 220,
      spriteId: 10,
      assetPath: 'spa6.png',
      level: 2,
      bulletId: 11,
      bulletPath: 'assets/images/bl6.png'
  ),
  SpaceShip(
      name: 'Carnage',
      cost: 17,
      speed: 250,
      spriteId: 8,
      assetPath: 'spa5.png',
      level: 3,

      bulletId: 9,
      bulletPath: 'assets/images/bl5.png'
  ),

  SpaceShip(
      name: 'Icarus',
      cost: 21,
      speed: 270,
      spriteId: 6,
      assetPath: 'spa4.png',
      level: 4,
      bulletId: 7,
      bulletPath: 'assets/images/bl4.png'
  ),
  SpaceShip(
      name: 'BS Titan',
      cost: 25,
      speed: 280,
      spriteId: 4,
      assetPath: 'spa3.png',
      level: 5,
      bulletId: 5,
      bulletPath: 'assets/images/bl3.png'
  ),

  SpaceShip(
      name: 'USS Troy',
      cost: 28,
      speed: 290,
      spriteId: 2,
      assetPath: 'spa2.png',
      level: 6,
      bulletId: 3,
      bulletPath: 'assets/images/bl2.png'
  ),
  SpaceShip(
      name: 'HMS Blade',
      cost: 33,
      speed: 310,
      spriteId: 12,
      assetPath: 'spa7.png',
      level: 7,
      bulletId: 13,
      bulletPath: 'assets/images/bl7.png'
  ),

  SpaceShip(
      name: 'CS Sagittarius',
      cost: 35,
      speed: 320,
      spriteId: 16,
      assetPath: 'spa9.png',
      level: 8,
      bulletId: 17,
      bulletPath: 'assets/images/bl9.png'
  ),


  SpaceShip(
    name: 'BS Independence',
    cost: 0,
    speed: 36,
    spriteId: 0,
    assetPath: 'spa1.png',
    level: 9,
    bulletId: 1,
    bulletPath: 'assets/images/bl1.png'
  ),



   SpaceShip(
    name: 'STS Silent',
    cost: 40,
    speed: 340,
    spriteId: 14,
    assetPath: 'spa8.png',
    level: 10,
       bulletId: 15,
       bulletPath: 'assets/images/bl8.png'
  ),

  SpaceShip(
      name: 'Pioneer',
      cost: 50,
      speed: 350,
      spriteId: 22,
      assetPath: 'spa12.png',
      level: 11,
      bulletId: 23,
      bulletPath: 'assets/images/bl12.png'
  ),
  SpaceShip(
    name: 'Helios',
    cost: 60,
    speed: 380,
    spriteId: 20,
    assetPath: 'spa11.png',
    level: 12,
      bulletId: 21,
      bulletPath: 'assets/images/bl11.png'
  ),

];