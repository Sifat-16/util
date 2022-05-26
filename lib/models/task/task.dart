import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{
  @HiveField(0)
  late String task;
  @HiveField(1)
  late String? description;
  @HiveField(2)
  late int importance;
  @HiveField(3)
  late bool completed=false;
  @HiveField(4)
  late String date;
  @HiveField(5)
  late String? time;

}