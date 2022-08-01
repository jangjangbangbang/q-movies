import 'package:get/get.dart';
import 'package:q_movies/modules/global_widgets/movie_widget/movie_widget_controller.dart';

class MovieWidgetBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MovieWidgetController>(MovieWidgetController());
  }
}
