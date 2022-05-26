import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:util/screens/game/baseG.dart';
import 'package:util/screens/game/models/starting_module.dart';

class AudioManager extends Component with HasGameRef<SpaceShooter>{

  @override
  Future<void>? onLoad() {
    FlameAudio.bgm.initialize();

    FlameAudio.audioCache.loadAll(["laser.ogg", "space.wav"]);

    return super.onLoad();
  }


  void playBgm(String filename){
    if(gameRef.buildContext!=null&&startingModule.backgroundMusic==1){
      FlameAudio.bgm.play(filename);
    }

  }

  void playSfx(String filename){
    if(gameRef.buildContext!=null&&startingModule.sfxMusic==1){
      FlameAudio.play(filename);
    }

  }

  void stopBgm(){
    FlameAudio.bgm.stop();
  }

}