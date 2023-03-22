// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_images.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteBox extends TypeAdapter<FavoriteImage> {
  @override
  final int typeId = 1;

  @override
  FavoriteImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteImage(
      imageUrl: fields[0] as String?,
      id: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteImage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteBox &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
