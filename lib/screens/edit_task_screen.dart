import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:note/utility/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';
import '../widget/task_type_item.dart';

class EditTaskScreen extends StatefulWidget {
  Task task;
  EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var focusTask1 = FocusNode();
  var focusTask2 = FocusNode();
  TextEditingController? titleEditing;
  TextEditingController? subEditing;
  DateTime? _time;
  final box = Hive.box<Task>('taskBox');
  int? _selectedTaskTypeitem = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleEditing = TextEditingController(text: widget.task.title);
    subEditing = TextEditingController(text: widget.task.subtitle);

    focusTask1.addListener(() {
      setState(() {});
    });
    focusTask2.addListener(() {
      setState(() {});
    });

    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });

    _selectedTaskTypeitem = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(right: 44, left: 44),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: titleEditing,
                focusNode: focusTask1,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  labelText: "عنوان تسک",
                  labelStyle: TextStyle(
                      fontSize: 20,
                      color: focusTask1.hasFocus
                          ? Color(0xff18DAA3)
                          : Color(0xffC5C5C5)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Color(0xffC5C5C5), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: Color(0xff18DAA3),
                      width: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 44, left: 44),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: subEditing,
                maxLines: 2,
                focusNode: focusTask2,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  labelText: "عنوان تسک",
                  labelStyle: TextStyle(
                      fontSize: 20,
                      color: focusTask2.hasFocus
                          ? Color(0xff18DAA3)
                          : Color(0xffC5C5C5)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Color(0xffC5C5C5), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: Color(0xff18DAA3),
                      width: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomHourPicker(
            title: 'زمان تسک را انتخاب کن',
            negativeButtonText: 'حذف کن',
            titleStyle: TextStyle(
                color: Color(0xff18DAA3),
                fontWeight: FontWeight.bold,
                fontSize: 18),
            negativeButtonStyle: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
            positiveButtonStyle: TextStyle(
                color: Color(0xff18DAA3),
                fontWeight: FontWeight.bold,
                fontSize: 18),
            positiveButtonText: 'انتخاب زمان',
            elevation: 2,
            onNegativePressed: (context) {},
            onPositivePressed: (context, time) {
              _time = time;
            },
          ),
          Container(
            height: 190,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getTaskTypeList().length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTaskTypeitem = index;
                      });
                    },
                    child: TaskTypeItem(
                      taskType: getTaskTypeList()[index],
                      index: index,
                      selectedItemList: _selectedTaskTypeitem!,
                    ),
                  );
                }),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 48), primary: Color(0xff18DAA3)),
                onPressed: () {
                  String taskTitle = titleEditing!.text;
                  String taskSubtitle = subEditing!.text;
                  editTask(taskTitle, taskSubtitle);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "ویرایش کردن تسک",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ))),
    );
  }

  editTask(String taskTitle, String taskSubtitle) {
    widget.task.title = taskTitle;
    widget.task.subtitle = taskSubtitle;
    widget.task.dateTime = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskTypeitem!];
    widget.task.save();
  }
}
