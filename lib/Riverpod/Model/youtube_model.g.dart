// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YoutubeModelAdapter extends TypeAdapter<YoutubeModel> {
  @override
  final int typeId = 5;

  @override
  YoutubeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return YoutubeModel(
      link: fields[0] as String,
      name: fields[1] as String,
      createDate: fields[2] as String,
      expiryDate: fields[3] as String,
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, YoutubeModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.link)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createDate)
      ..writeByte(3)
      ..write(obj.expiryDate)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YoutubeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
