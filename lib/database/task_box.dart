import 'package:hive/hive.dart';
import 'package:util/models/task/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskBox{
  static Box<Task> getTasks() => Hive.box("taskBox");

}

Future addTask(String task, String? desc, int importance, bool completed, String date, String? time) async{
  final tsk = Task()
      ..task=task
      ..description=desc
      ..importance=importance
      ..completed=completed
      ..date=date
  ..time=time;
  final box = TaskBox.getTasks();
  await box.add(tsk);

}

Future editTask(Task tk, String task, String? desc, int importance, bool completed, String date, String? time) async{
  tk.task=task;
  tk.description=desc;
  tk.importance=importance;
  tk.completed=completed;
  tk.date=date;
  if(time!=null){
    tk.time = time;
  }

  await tk.save();
}

Future deleteTask(Task tk) async{
  await tk.delete();
}

Future completeTaskorNot(Task tk) async{
  tk.completed=!tk.completed;
  await tk.save();
}