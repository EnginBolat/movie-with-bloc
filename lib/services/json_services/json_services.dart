import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app_bloc/constants/app_api.dart';
import 'package:movie_app_bloc/model/trending_movies_model.dart';

class JsonServices {
  Future<List<Results>?> fetchTrendingMovies() async {
    try {
      final response = await Dio().get(ApiConst.trendingMovies);
      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data["results"];

        if (datas is List) {
          return datas.map((e) => Results.fromJson(e)).toList();
        }
      }
    } on DioError catch (error) {
      _ShowDebug.showDioError(error);
    }
    return null;
  }

  Future<List<Results>?> fetchPopularMovies() async {
    try {
      final response = await Dio().get(ApiConst.popularMovies);
      if (response.statusCode == HttpStatus.ok) {
        var data = response.data["results"];
        if (data is List) {
          return data.map((e) => Results.fromJson(e)).toList();
        }
      }
    } on DioError catch (e) {
      _ShowDebug.showDioError(e);
    }
    return null;
  }
}

class _ShowDebug {
  static void showDioError(DioError error) {
    if (kDebugMode) {
      print(error.message);
    }
  }
}
