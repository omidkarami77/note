import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../data/task.dart';
import '../screens/edit_task_screen.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget({super.key, required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;
  var box = Hive.box<Task>('taskBox');

  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: getMainContent(),
        ),
      ),
    );
  }

  Widget getMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        value: isBoxChecked,
                        onChanged: (isChecked) {
                          setState(() {
                            isBoxChecked = isChecked!;
                            widget.task.isDone = isBoxChecked;
                            widget.task.save();
                          });
                        },
                      ),
                    ),
                    Text(widget.task.title.toString())
                  ],
                ),
                Text(
                  widget.task.subtitle.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                getTimeAndEditBadgs(),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Image.asset(widget.task.taskType.image),
        ],
      ),
    );
  }

  Row getTimeAndEditBadgs() {
    return Row(
      children: [
        Container(
          width: 94,
          height: 28,
          decoration: BoxDecoration(
            color: Color(0xff18DAA3),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Row(children: [
              Text(
                "${getHourUnderThen(widget.task.dateTime)} : ${getMinuteUnderThen(widget.task.dateTime)}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              SizedBox(
                width: 10,
              ),
              Image.asset("images/icon_time.png"),
            ]),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditTaskScreen(
                      task: widget.task,
                    )));
          },
          child: Container(
            width: 94,
            height: 28,
            decoration: BoxDecoration(
              color: Color(0xffE2F6F1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  "ویرایش",
                  style: TextStyle(color: Color(0xff18DAA3)),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset("images/icon_edit.png"),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  String getMinuteUnderThen(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }

  String getHourUnderThen(DateTime time) {
    if (time.hour < 10) {
      return '0${time.hour}';
    } else {
      return time.hour.toString();
    }
  }
}
