import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Future<Widget> mySpriteWidget;

  Future<Widget> SpriteSheetProvider() async {
    Flame.images.clearCache();
    ui.Image myImage = await Flame.images.load('spritesheet.png');
    final SpriteSheet mySpriteSheet =
    SpriteSheet.fromColumnsAndRows(columns: 60, image: myImage, rows: 1);
    final Sprite sprite = mySpriteSheet.getSprite(1, 1);
    final SpriteWidget mySpriteWidget = SpriteWidget(sprite: sprite);
    print('hi');
    return Text('hello');
  }


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 5000));
    animationController.repeat();
    mySpriteWidget = SpriteSheetProvider();

    // SpriteWidget mySpriteWidget = snapshot.data as SpriteWidget;

  }
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final logoWidth = screenWidth * 0.4;
    final logoHeight = logoWidth * 1197 / 959;



    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/WoodenFloor.png',
          width: screenWidth,
          height: screenHeight,
          fit: BoxFit.fill,
        ),
        FutureBuilder(
            future: mySpriteWidget,
            builder: (context,snapshot){
              print('future builder being run');
              print(snapshot.connectionState);
              //AsyncSnapshot

              if(snapshot.hasData){

                return Text('hello');}
              else if(snapshot.connectionState == ConnectionState.waiting){ return Text('waiting');}
              else{ return Text(snapshot.data.toString());}
          
        })

        // AnimatedBuilder(
        //
        //   animation: animationController,
        //   builder: (context,child) {
        //     double animationValue = animationController.value;
        //     Rect myRect = Rect.fromCircle(center: Offset(0,0), radius: logoWidth,);
        //
        //     Image myImage = Image.asset(
        //       'assets/GlowingClock.png',
        //       height: screenHeight/1.2,
        //       width: screenWidth/1.2, fit: BoxFit.contain,);
        //
        //     // ui.PictureRecorder myRecorder = ui.PictureRecorder();
        //     // ui.Image canvasImage;
        //     // Canvas canvas = Canvas(myRecorder);
        //     // canvas.drawImageRect(canvasImage, src, dst, paint)
        //
        //     return Transform.translate(offset: Offset(0,0),
        //     child: myImage);
        //   }
        // ),

      ],
    );
  }
}

class AnimatedImages extends StatelessWidget {
  const AnimatedImages({Key? key, required Widget this.imageWidget, int this.imageSections=1, required double this.animationValue, required this.size}) : super(key: key);
  final Widget imageWidget;
  final int imageSections;
  final double animationValue;
  final Size size;

  double transformOffset(int imageSections,Size size,int activeSection){
    double widthBy2 = size.width/2;
    double offsetConstant = widthBy2/imageSections;
    double offset = activeSection*offsetConstant;

    return offset;
  }

  @override
  Widget build(BuildContext context) {
    final int activeSection = (animationValue*imageSections-1).ceil();

    return Transform.translate(
      offset: Offset(0,0),
      child: ClipPath(
        clipper: MyCustomClipper(imageSections:2,animationValue:animationValue),
        child: imageWidget,
      ),
    );
  }
}


class MyCustomClipper extends CustomClipper<Path>{
  MyCustomClipper({Key? key, int this.imageSections=1, required double this.animationValue});
  int imageSections;
  double animationValue;

  double activeSectionOffset(int imageSections,Size size,int activeSection){
    double width = size.width;
    double offsetConstant = width/imageSections;
    double offset = activeSection*offsetConstant;

    return offset;
  }


  @override
  Path getClip(Size size) {
    int activeSection = (animationValue*imageSections-1).ceil();
    double width = size.width;
    double height = size.height;
    double sectionWidth = size.width/imageSections;
    double offset = activeSectionOffset(imageSections,size,activeSection);
    //double offset = size.width/2;
    Path path = Path();
    path.moveTo(offset, 0);
    path.lineTo(sectionWidth+offset, 0);
    path.lineTo(0+offset, height);
    path.moveTo(sectionWidth+offset, height);
    path.lineTo(sectionWidth+offset, 0);
    path.lineTo(0+offset, height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
  
}
