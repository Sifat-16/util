// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditAdapter extends TypeAdapter<Credit> {
  @override
  final int typeId = 1;

  @override
  Credit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Credit()
      ..name = fields[0] as String
      ..uid = fields[1] as String
      ..dateToPay = fields[2] as String?
      ..importance = fields[3] as int
      ..type = fields[4] as int
      ..paid = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, Credit obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.dateToPay)
      ..writeByte(3)
      ..write(obj.importance)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.paid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AmountAdapter extends TypeAdapter<Amount> {
  @override
  final int typeId = 2;

  @override
  Amount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Amount()
      ..reason = fields[0] as String?
      ..date = fields[1] as String
      ..amount = fields[2] as double
      ..paid = fields[3] as bool
      ..payDate = fields[4] as String?
      ..creditorUid = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, Amount obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.reason)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.paid)
      ..writeByte(4)
      ..write(obj.payDate)
      ..writeByte(5)
      ..write(obj.creditorUid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AmountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
