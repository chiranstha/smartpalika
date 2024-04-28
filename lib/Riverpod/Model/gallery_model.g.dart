// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GalleryListAdapter extends TypeAdapter<GalleryList> {
  @override
  final int typeId = 4;

  @override
  GalleryList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GalleryList(
      photoBytes: fields[0] as String,
      title: fields[1] as String,
      id: fields[2] as String,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GalleryList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.photoBytes)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
