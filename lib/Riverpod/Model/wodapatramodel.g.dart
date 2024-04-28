// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wodapatramodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WodaPatraModelAdapter extends TypeAdapter<WodaPatraModel> {
  @override
  final int typeId = 2;

  @override
  WodaPatraModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WodaPatraModel(
      serviceName: fields[0] as String,
      importDocument: fields[1] as String,
      requiredDocument: fields[2] as String,
      responsiblePerson: fields[3] as String,
      rate: fields[4] as String,
      time: fields[5] as String,
      remark: fields[6] as String,
      order: fields[7] as int,
      id: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WodaPatraModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.serviceName)
      ..writeByte(1)
      ..write(obj.importDocument)
      ..writeByte(2)
      ..write(obj.requiredDocument)
      ..writeByte(3)
      ..write(obj.responsiblePerson)
      ..writeByte(4)
      ..write(obj.rate)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.remark)
      ..writeByte(7)
      ..write(obj.order)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WodaPatraModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
