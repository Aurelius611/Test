import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/image_composition.dart';


void main() {
  runApp(
      GameWidget(game: MyGame())
  );
}

class MyGame extends FlameGame {

  @override
  Future<void> onLoad() async {
    print('loading assets');

    await super.onLoad();
    var myImage = await Images().load('spritesheet.png');
    SpriteSheet mySheet = SpriteSheet(image: myImage, srcSize: Vector2(1080,1980));

    SpriteAnimation myAnimation = SpriteAnimation.spriteList([mySheet.getSpriteById(0),mySheet.getSpriteById(30),mySheet.getSpriteById(60)], stepTime: 0.1);
    SpriteAnimationComponent clock = SpriteAnimationComponent(animation: myAnimation);
    
    add(clock);
    print('completed loading assets');
  }
}
