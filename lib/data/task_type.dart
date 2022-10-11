import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/data/type_enum.dart';

part 'task_type.g.dart';

@HiveType(typeId: 4)
class TaskType extends HiveObject {
  @HiveField(0)
  String image;
  @HiveField(1)
  String title;
  @HiveField(2)
  TaskTypeEnum taskTypeEnum;

  TaskType(
      {required this.image, required this.title, required this.taskTypeEnum});
}
