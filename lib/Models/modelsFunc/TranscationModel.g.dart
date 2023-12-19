// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TranscationModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranscaitonModelAdapter extends TypeAdapter<TranscaitonModel> {
  @override
  final int typeId = 3;

  @override
  TranscaitonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranscaitonModel(
      purpose: fields[1] as String,
      amount: fields[2] as double,
      isDeleted: fields[3] as bool,
      date: fields[4] as DateTime,
      type: fields[5] as CategoryType,
      category: fields[6] as CategoryModel,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, TranscaitonModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.purpose)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.isDeleted)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranscaitonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
