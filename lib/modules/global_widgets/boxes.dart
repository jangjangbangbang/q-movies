import 'package:hive/hive.dart';
import 'package:q_movies/models/cache_hive.dart';
import 'package:q_movies/models/movie.dart';

class Boxes {
  static Box<CacheHive> getCacheHive() => Hive.box<CacheHive>('cacheHive');
  static Box<Movie> getFavourites() => Hive.box<Movie>('favourites');
}
