import 'package:json_annotation/json_annotation.dart';
import 'package:q_movies/models/genre.dart';

part 'genre_list.g.dart';

/// GenreList model
@JsonSerializable()
class GenreList {
  /// {@macro paginated_api_response}
  const GenreList({
    required this.genres,
  });

  factory GenreList.fromJson(Map<String, dynamic> json) =>
      _$GenreListFromJson(json);
  Map<String, dynamic> toJson() => _$GenreListToJson(this);

  final List<Genre>? genres;
}
