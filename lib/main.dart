import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/screens/home_screen.dart';

import 'data/task.dart';
import 'data/task_type.dart';
import 'data/type_enum.dart';

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('names');
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());

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
