// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sugar_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SugarLogModelAdapter extends TypeAdapter<SugarLogModel> {
  @override
  final int typeId = 20;

  @override
  SugarLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SugarLogModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      loggedAt: fields[2] as DateTime,
      sugarType: fields[3] as String,
      label: fields[4] as String,
      estimatedSugarGrams: fields[5] as double,
      estimatedCalories: fields[6] as double,
      note: fields[7] as String?,
      xpEarned: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SugarLogModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.loggedAt)
      ..writeByte(3)
      ..write(obj.sugarType)
      ..writeByte(4)
      ..write(obj.label)
      ..writeByte(5)
      ..write(obj.estimatedSugarGrams)
      ..writeByte(6)
      ..write(obj.estimatedCalories)
      ..writeByte(7)
      ..write(obj.note)
      ..writeByte(8)
      ..write(obj.xpEarned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SugarLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
