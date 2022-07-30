import 'package:json_annotation/json_annotation.dart';
import 'package:q_movies/models/movie.dart';

part 'paginated_api_response.g.dart';

@JsonSerializable()
class PaginatedApiResponse {
  const PaginatedApiResponse({
    required this.page,
    this.results,
    required this.totalPages,
  });

  factory PaginatedApiResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaginatedApiResponseToJson(this);

  final int page;
  @JsonKey(name: 'results')
  final List<Movie>? results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
}
