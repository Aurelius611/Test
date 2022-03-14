import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flame/image_composition.dart';
import 'dart:ui' as ui;


void main() {
  runApp(
    MyApp()
      //GameWidget(game: MyGame())
  );
}

/// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: GameWidget(game: MyGame(),)),
      ),
    );
  }
}


class MyGame extends FlameGame {

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    print('loading assets');
    var myImage = await Images().load('spritesheet.png');
    SpriteSheet mySheet = SpriteSheet(image: myImage, srcSize: Vector2(1080,1980));
    int spriteSheetLength = 59;
    Vector2 spriteSize = Vector2(108*4,198*4);

    List<SpriteComponent> clockAnimationSprites = List.generate(spriteSheetLength, (index) => SpriteComponent());
    for(int i=0; i<spriteSheetLength;i++){
      clockAnimationSprites[i]..sprite =
      mySheet.getSpriteById(i)
        ..size = spriteSize
        ..x = 0
        ..y = 0;
    }

    List<Sprite> clockSprites = List.generate(spriteSheetLength, (index) => clockAnimationSprites[index].sprite!);
    SpriteAnimation spriteAnimation = SpriteAnimation.spriteList(clockSprites, stepTime: 0.037);
    SpriteAnimationComponent spriteAnimationComponent = SpriteAnimationComponent(animation: spriteAnimation,size:spriteSize);
    add(spriteAnimationComponent);

    print('completed loading assets');
  }
  
}

