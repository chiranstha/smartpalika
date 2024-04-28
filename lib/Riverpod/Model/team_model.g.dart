// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeamModelAdapter extends TypeAdapter<TeamModel> {
  @override
  final int typeId = 3;

  @override
  TeamModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeamModel(
      name: fields[0] as String,
      jobTitle: fields[1] as String,
      shortDescription: fields[2] as dynamic,
      description: fields[3] as dynamic,
      phone: fields[4] as String,
      email: fields[5] as dynamic,
      photo: fields[6] as dynamic,
      photoFileName: fields[8] as dynamic,
      isPublished: fields[9] as dynamic,
      id: fields[10] as String,
      photoBytes: fields[7] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, TeamModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.jobTitle)
      ..writeByte(2)
      ..write(obj.shortDescription)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.photo)
      ..writeByte(7)
      ..write(obj.photoBytes)
      ..writeByte(8)
      ..write(obj.photoFileName)
      ..writeByte(9)
      ..write(obj.isPublished)
      ..writeByte(10)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
