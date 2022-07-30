import 'package:get/get.dart';
import 'package:q_movies/modules/movies/movies_controller.dart';

class MoviesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MoviesController>(MoviesController());
  }
}
