// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls

import 'package:get/get.dart';
import 'package:q_movies/models/movie.dart';

class MovieDetailsController extends GetxController {
  dynamic argumentData = Get.arguments;
  late Movie movie;
  late List<int> allGenreIds;
  late List<String> allGenreNames;
  final isBookmarked = false.obs;
  late bool fromFave;

  @override
  void onInit() {
    super.onInit();
    movie = argumentData[0]['movie'] as Movie;
    allGenreIds = argumentData[0]['allGenreIds'] as List<int>;
    allGenreNames = argumentData[0]['allGenreNames'] as List<String>;
    isBookmarked.value = argumentData[0]['isBookmarked'] as bool;
    fromFave = argumentData[0]['fromFave'] as bool;
  }
}
