import 'package:get/get.dart';
import 'package:q_movies/models/movie.dart';
import 'package:q_movies/modules/global_widgets/boxes.dart';

class MovieWidgetController extends GetxController {
  final faveBox = Boxes.getFavourites();

  Future<void> addToFavourites({required Movie movie}) async {
    await faveBox.put(movie.id, movie);
  }

  Future<void> removeFromFavourites({required Movie movie}) async {
    await faveBox.delete(movie.id);
  }
}
