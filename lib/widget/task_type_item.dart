import 'package:flutter/material.dart';

import '../data/task_type.dart';

class TaskTypeItem extends StatelessWidget {
  TaskTypeItem(
      {super.key,
      required this.taskType,
      required this.index,
      required this.selectedItemList});
  TaskType taskType;
  int index;
  int selectedItemList;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (selectedItemList == index) ? Colors.green : Colors.white,
          border: Border.all(
              color: (selectedItemList == index)
                  ? Colors.green
                  : Colors.transparent,
              width: 2),
          borderRadius: BorderRadius.all(Radius.circular(18))),
      width: 140,
      margin: EdgeInsets.all(8),
      child: Column(children: [
        Image.asset(taskType.image),
        Text(
          taskType.title,
          style: TextStyle(
            fontSize: 16,
            color: (selectedItemList == index) ? Colors.white : Colors.black,
          ),
        )
      ]),
    );
  }
}
