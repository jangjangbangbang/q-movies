// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:q_movies/models/cache_hive.dart';
import 'package:q_movies/models/genre.dart';
import 'package:q_movies/models/genre_list.dart';
import 'package:q_movies/models/movie.dart';
import 'package:q_movies/models/paginated_api_response.dart';
import 'package:q_movies/modules/global_widgets/boxes.dart';
import 'package:q_movies/modules/home/home_controller.dart';
import 'package:q_movies/provider/http_service.dart';

class MoviesController extends GetxController {
  final homeController = Get.find<HomeController>();
  final isLoading = true.obs;
  RxList<Movie> movies = RxList([]);
  RxList<Genre> genres = RxList([]);
  int page = 1;
  final reachedEndOfPage = false.obs;
  HttpService http = HttpService();
  final scrollController = ScrollController();

  List<int> allGenreIds = [];
  List<String> allGenreNames = [];

  final boxCache = Boxes.getCacheHive();
  final isBoxCacheEmpty = true.obs;

  final faveMovies = Boxes.getFavourites();
  RxList<int> faveMoviesId = RxList([]);

  RxList<bool> isFaveMovieList = RxList([]);

  @override
  Future<void> onInit() async {
    super.onInit();
    scrollController.addListener(() {
      if (homeController.hasInternet.value) {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          page += 1;
          fetchDataFromApi(page: page);
        }
      }
    });

    await homeController.checkConnectivity();
    homeController.hasInternet.value
        ? await fetchDataFromApi(page: page)
        : boxCache.isEmpty
            ? isBoxCacheEmpty.value = true
            : fetchDataFromHive();
  }

  void refreshData() {
    movies.clear();
    isLoading.value = true;
    page = 1;
    reachedEndOfPage.value = false;
    fetchDataFromApi(page: page);
  }

  ///Fetch data from api and update cache data
  Future<void> fetchDataFromApi({required int page}) async {
    const baseUrl = 'https://api.themoviedb.org/3/';
    final endPoint = '${baseUrl}movie/popular?language=en_US&page=$page';
    const genreListUrl = 'https://api.themoviedb.org/3/genre/movie/list';

    try {
      final response = await http.getRequest(endPoint);
      final genreList = await http.getRequest(genreListUrl);
      if (response.statusCode == 200) {
        await boxCache.clear();
        final paginatedApiResponse = PaginatedApiResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        final genreResponse = GenreList.fromJson(
          genreList.data as Map<String, dynamic>,
        );
        movies.addAll(paginatedApiResponse.results ?? []);
        genres.addAll(genreResponse.genres ?? []);

        if (allGenreIds.isEmpty && genres.isNotEmpty) {
          genres.map((genre) {
            final genreId = genre.id;
            final genreName = genre.name;
            allGenreIds.add(genreId);
            allGenreNames.add(genreName);
          }).toList();
        }

        if (page >= paginatedApiResponse.totalPages) {
          reachedEndOfPage.value = true;
        }

        await cacheMovies(movies: movies, genres: genres);

        await fetchFavourites();

        isFaveMovieList.value =
            List<bool>.filled(movies.length + 20, false, growable: true);

        for (var i = 0; i < movies.length; i++) {
          faveMoviesId.map((id) {
            if (movies[i].id == id) isFaveMovieList[i] = true;
          }).toList();
        }

        // faveMovies.values.map((faveMovie) {
        //   for (var i = 0; i < movies.length; i++) {
        //     if (faveMovie.id == movies[i].id) isFaveMovieList[i] = true;
        //   }
        // });

        isLoading.value = false;
      } else {
        await Fluttertoast.showToast(
          gravity: ToastGravity.CENTER,
          msg: 'Something went wrong, Please try again',
        );
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  ///Cache data from api
  Future<void> cacheMovies({
    required List<Movie> movies,
    required List<Genre> genres,
  }) async {
    final cacheMovies = CacheHive()
      ..movies = movies
      ..genres = genres;

    await boxCache.add(cacheMovies);
  }

  ///Fetch data from cached hive
  Future<void> fetchDataFromHive() async {
    boxCache.values.map((cacheData) {
      movies.addAll(cacheData.movies);
      genres.addAll(cacheData.genres);
    }).toList();

    if (allGenreIds.isEmpty && genres.isNotEmpty) {
      genres.map((genre) {
        final genreId = genre.id;
        final genreName = genre.name;
        allGenreIds.add(genreId);
        allGenreNames.add(genreName);
      }).toList();
    }

    await fetchFavourites();

    isFaveMovieList.value =
        List<bool>.filled(movies.length + 20, false, growable: true);

    for (var i = 0; i < movies.length; i++) {
      faveMoviesId.map((id) {
        if (movies[i].id == id) isFaveMovieList[i] = true;
      }).toList();
    }

    isLoading.value = false;
  }

  Future<void> fetchFavourites() async {
    faveMoviesId.clear();
    faveMovies.values.map((fave) {
      faveMoviesId.add(fave.id);
    }).toList();
  }

  Future<bool> onWillPop() async {
    var backButtonPressedTime = DateTime.now();
    final difference = DateTime.now().difference(backButtonPressedTime);
    final isExitWarning = difference >= const Duration(seconds: 2);

    backButtonPressedTime = DateTime.now();

    if (isExitWarning) {
      await Fluttertoast.showToast(msg: 'Press back again to exit');
      return false;
    } else {
      await Fluttertoast.cancel();
      return true;
    }
  }
}
