import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../data/task.dart';
import '../widget/task_widget.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  var isFabVisible = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  setState(() {
                    if (notification.direction == ScrollDirection.forward) {
                      isFabVisible = true;
                    }

                    if (notification.direction == ScrollDirection.reverse) {
                      isFabVisible = false;
                    }
                  });

                  return true;
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var task = taskBox.values.toList()[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: getLIstItem(task),
                    );
                  },
                  itemCount: taskBox.values.length,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()));
          },
          backgroundColor: Color(0xff18DAA3),
          child: Image.asset("images/icon_add.png"),
        ),
      ),
    );
  }

  Widget getLIstItem(Task task) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          task.delete();
        },
        child: TaskWidget(task: task));
  }
}
