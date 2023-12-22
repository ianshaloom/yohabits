// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnboardAdapter extends TypeAdapter<Onboard> {
  @override
  final int typeId = 4;

  @override
  Onboard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Onboard(
      showOnboard: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Onboard obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.showOnboard);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
