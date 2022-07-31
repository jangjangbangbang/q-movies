// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:q_movies/models/genre.dart';
import 'package:q_movies/models/genre_list.dart';
import 'package:q_movies/models/movie.dart';
import 'package:q_movies/models/paginated_api_response.dart';
import 'package:q_movies/provider/http_service.dart';

class MoviesController extends GetxController {
  final isLoading = true.obs;
  RxList<Movie> movies = RxList([]);
  RxList<Genre> genres = RxList([]);
  int page = 1;
  final reachedEndOfPage = false.obs;
  HttpService http = HttpService();
  final scrollController = ScrollController();

  List<int> allGenreIds = [];
  List<String> allGenreNames = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        page += 1;
        fetchData(page: page);
      }
    });
    await fetchData(page: page);
  }

  void resetData() {
    movies.clear();
    isLoading.value = true;
    page = 1;
    reachedEndOfPage.value = false;
  }

  Future<void> fetchData({required int page}) async {
    const baseUrl = 'https://api.themoviedb.org/3/';
    final endPoint = '${baseUrl}movie/popular?language=en_US&page=$page';
    const genreListUrl = 'https://api.themoviedb.org/3/genre/movie/list';

    try {
      final response = await http.getRequest(endPoint);
      final genreList = await http.getRequest(genreListUrl);
      if (response.statusCode == 200) {
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
