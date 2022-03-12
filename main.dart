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
        body: SafeArea(child: MySpriteWidget()),
      ),
    );
  }
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


class MySpriteWidget extends StatelessWidget {
  MySpriteWidget({Key? key}) : super(key: key);

  Future<ui.Image> myImage =Images().load('spritesheet.png');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myImage,
      builder: (context,snapshot) {
        print(snapshot.connectionState);
        if(snapshot.connectionState == ConnectionState.done){
          ui.Image myImage = snapshot.data as ui.Image;
          Sprite mySprite = Sprite(myImage);
          return Container(
          width: 108*4,
          height: 198*4,
          decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
          child: SpriteWidget(
            sprite: mySprite,
            srcSize: Vector2(108*4,198*4),
          ),
        );}
        else {
          return Text('Future Did Not Resolve Correctly');
        }
      }
    );
  }
}

