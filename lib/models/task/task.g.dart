// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task()
      ..task = fields[0] as String
      ..description = fields[1] as String?
      ..importance = fields[2] as int
      ..completed = fields[3] as bool
      ..date = fields[4] as String
      ..time = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.importance)
      ..writeByte(3)
      ..write(obj.completed)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
