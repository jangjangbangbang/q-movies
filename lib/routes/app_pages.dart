// ignore_for_file: avoid_classes_with_only_static_members

import 'package:get/get.dart';
import 'package:q_movies/modules/home/home_binding.dart';
import 'package:q_movies/modules/home/home_screen.dart';
import 'package:q_movies/modules/movies/movies_binding.dart';
import 'package:q_movies/modules/movies/movies_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
      bindings: [
        HomeBinding(),
        MoviesBinding(),
      ],
      children: [
        GetPage(
          name: '/movies',
          page: () => const MoviesScreen(),
        ),
        GetPage(
          name: '/favourites',
          page: () => const MoviesScreen(),
        ),
      ],
    ),
  ];
}
