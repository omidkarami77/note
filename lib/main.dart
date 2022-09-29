import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/add_task_screen.dart';
import 'package:note/task.dart';

import 'home_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('names');
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "shabnam",
      ),
      home: HomeScreen(),
    );
  }
}
