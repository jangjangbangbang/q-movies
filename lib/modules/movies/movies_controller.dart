// ignore_for_file: lines_longer_than_80_chars

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
  final page = 1;
  HttpService http = HttpService();

  List<int> allGenreIds = [];
  List<String> allGenreNames = [];

  @override
  Future<void> onInit() async {
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    const baseUrl = 'https://api.themoviedb.org/3/';
    final endPoint = '${baseUrl}movie/popular?language=en_US&page=$page';
    const genreListUrl = 'https://api.themoviedb.org/3/genre/movie/list';

    try {
      isLoading.value = true;
      final response = await http.getRequest(endPoint);
      final genreList = await http.getRequest(genreListUrl);
      if (response.statusCode == 200) {
        final paginatedApiResponse = PaginatedApiResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        final genreResponse = GenreList.fromJson(
          genreList.data as Map<String, dynamic>,
        );
        movies.value = paginatedApiResponse.results ?? [];
        genres.value = genreResponse.genres ?? [];

        if (allGenreIds.isEmpty && genres.isNotEmpty) {
          genres.map((genre) {
            final genreId = genre.id;
            final genreName = genre.name;
            allGenreIds.add(genreId);
            allGenreNames.add(genreName);
          }).toList();
        }

        isLoading.value = false;
      } else {
        await Fluttertoast.showToast(
          gravity: ToastGravity.CENTER,
          msg: 'Something went wrong, Please try again',
        );
      }
    } catch (e) {
      print(e);
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
