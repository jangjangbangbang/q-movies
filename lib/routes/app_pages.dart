// ignore_for_file: avoid_classes_with_only_static_members

import 'package:get/get.dart';
import 'package:q_movies/modules/home/home_binding.dart';
import 'package:q_movies/modules/home/home_screen.dart';
import 'package:q_movies/modules/movie_details/movie_details_binding.dart';
import 'package:q_movies/modules/movie_details/movie_details_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: '/movie_details',
      page: () => const MovieDetailsScreen(),
      binding: MovieDetailsBinding(),
    ),
  ];
}
