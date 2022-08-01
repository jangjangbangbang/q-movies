import 'package:hive/hive.dart';
import 'package:q_movies/models/genre.dart';
import 'package:q_movies/models/movie.dart';

part 'cache_hive.g.dart';

@HiveType(typeId: 0)
class CacheHive extends HiveObject {
  @HiveField(0)
  late List<Movie> movies;

  @HiveField(1)
  late List<Genre> genres;
}
