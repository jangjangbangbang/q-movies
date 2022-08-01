// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheHiveAdapter extends TypeAdapter<CacheHive> {
  @override
  final int typeId = 0;

  @override
  CacheHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheHive()
      ..movies = (fields[0] as List).cast<Movie>()
      ..genres = (fields[1] as List).cast<Genre>();
  }

  @override
  void write(BinaryWriter writer, CacheHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.movies)
      ..writeByte(1)
      ..write(obj.genres);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
