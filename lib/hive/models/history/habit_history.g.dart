// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitsRecordAdapter extends TypeAdapter<HabitsRecord> {
  @override
  final int typeId = 1;

  @override
  HabitsRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitsRecord(
      habits: (fields[1] as List).cast<Habit>(),
      date: fields[2] as DateTime,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, HabitsRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.habits)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitsRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
