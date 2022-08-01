import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Genre {
  const Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
