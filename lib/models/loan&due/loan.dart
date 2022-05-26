import 'package:hive/hive.dart';

part 'loan.g.dart';

@HiveType(typeId: 1)
class Credit extends HiveObject{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String uid;
  @HiveField(2)
  late String? dateToPay;
  @HiveField(3)
  late int importance;
  @HiveField(4)
  late int type;
  @HiveField(5)
  late bool paid;
}

@HiveType(typeId: 2)
class Amount extends HiveObject{
  @HiveField(0)
  late String? reason;
  @HiveField(1)
  late String date;
  @HiveField(2)
  late double amount;
  @HiveField(3)
  late bool paid;
  @HiveField(4)
  late String? payDate;
  @HiveField(5)
  late String creditorUid;
}
