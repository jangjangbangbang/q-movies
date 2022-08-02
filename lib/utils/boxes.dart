import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:q_movies/models/cache_hive.dart';
import 'package:q_movies/models/movie.dart';

class Boxes {
  static Box<CacheHive> getCacheHive() => Hive.box<CacheHive>('cacheHive');
  static Box<Movie> getFavourites() => Hive.box<Movie>('favourites');
}

class BoxController extends GetxController {
  final faveBox = Boxes.getFavourites();

  Future<void> addToFavourites({required Movie movie}) async {
    await faveBox.put(movie.id, movie);
  }

  Future<void> removeFromFavourites({required Movie movie}) async {
    await faveBox.delete(movie.id);
  }
}
