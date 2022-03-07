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
    SpriteComponent clock = SpriteComponent();
    clock
      ..sprite = 
        mySheet.getSpriteById(30)
      ..size = Vector2(108*4,198*4)
      ..x = 0
      ..y = 0;
    add(clock);
    print('completed loading assets');
  }
}
