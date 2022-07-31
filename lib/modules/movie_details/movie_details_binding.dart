import 'package:get/get.dart';
import 'package:q_movies/modules/movie_details/movie_details_controller.dart';

class MovieDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MovieDetailsController>(MovieDetailsController());
  }
}
