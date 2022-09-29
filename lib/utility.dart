import 'package:note/task_type.dart';
import 'package:note/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
        image: 'images/meditate.png',
        title: 'تمرکز',
        taskTypeEnum: TaskTypeEnum.foucs),
    TaskType(
        image: 'images/social_frends.png',
        title: 'میتینگ',
        taskTypeEnum: TaskTypeEnum.date),
    TaskType(
        image: 'images/work_meeting.png',
        title: 'قرارکاری',
        taskTypeEnum: TaskTypeEnum.working),
    TaskType(
        image: 'images/workout.png',
        title: 'ورزش',
        taskTypeEnum: TaskTypeEnum.gym),
  ];
  return list;
}
