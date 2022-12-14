import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/data/task_type.dart';

part 'task.g.dart';

@HiveType(typeId: 3)
class Task extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? subtitle;

  @HiveField(2)
  bool isDone;
  @HiveField(3)
  DateTime dateTime;

  @HiveField(4)
  TaskType taskType;

  Task(
      {required this.title,
      required this.subtitle,
      this.isDone = false,
      required this.dateTime,
      required this.taskType});
}
