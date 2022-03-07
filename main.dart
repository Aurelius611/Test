import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_01_24_2022/Tests/hide_and_emphasize.dart';
import 'package:progress_01_24_2022/test.dart';
import 'package:progress_01_24_2022/visual_map.dart';
import 'package:progress_01_24_2022/welcome_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart' as panel;
import 'home_page.dart';
import 'visual_map.dart';
import 'tasks_details.dart';

void main() => runApp(const MyApp());

/// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Scaffold(
        //appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

/// App Body Widget
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Center(
        child: TestPage()//TasksList(),
      ),
    );
  }
}
class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}
class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return panel.SlidingUpPanel(
      body: const visualMap(), //this is the widget that is behind the panel
      minHeight: MediaQuery.of(context).size.height*0.10,
      maxHeight: MediaQuery.of(context).size.height*0.80,
      backdropEnabled: true,
      parallaxEnabled: true,
      color: Colors.indigoAccent,
      borderRadius: const BorderRadius.only(topLeft: Radius.elliptical(50, 25), topRight:Radius.elliptical(50, 25)),
      panel: Column(
        children: [
          const SizedBox(
            width: 10,
            height: 10,
          ),
          const Text(
            'Cluster Title',
            textScaleFactor: 3,
          ),
          const SizedBox(
            width: 10,
            height: 10,
          ),
          ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage()),);},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                Icon(Icons.add),
                Text('Add Task',textScaleFactor: 1.4,),
              ],
            ),
          ),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              children: TasksCardsGenerator(propertiesSupplier(5)),
              crossAxisCount: 1,
              mainAxisSpacing: 7,
              childAspectRatio: 3, //todo: GridView ruins the cards' aspect ratio. Fix without using this line, such that the size of the card varies based on content.
            ),
          ))
        ],
      ),
    );
  }
}

