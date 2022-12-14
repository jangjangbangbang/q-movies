// ignore_for_file: lines_longer_than_80_chars

import 'package:dio/dio.dart';

class HttpService {
  HttpService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
    );

    initializeInterceptors();
  }
  final _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOGQ3Zjc2OTQ3OTA0YTAxMTI4NmRjNzMyYzU1MjM0ZSIsInN1YiI6IjYwMzM3ODBiMTEzODZjMDAzZjk0ZmM2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XYuIrLxvowrkevwKx-KhOiOGZ2Tn-R8tEksXq842kX4';
  final baseUrl = 'https://api.themoviedb.org/3/';
  Dio _dio = Dio();

  Future<Response<dynamic>> getRequest(String endPoint) async {
    Response<dynamic> response;

    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      throw Exception(e.message);
    }

    return response;
  }

  void initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (err, handler) {
          handler.next(err);
        },
        onRequest: (request, handler) {
          handler.next(request);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
      ),
    );
  }
}
