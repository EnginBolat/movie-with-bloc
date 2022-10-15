import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app_bloc/constants/app_api.dart';
import 'package:movie_app_bloc/model/movie_model.dart';
import 'package:http/http.dart' as http;

import '../../model/movie_actor_model.dart';
import '../../model/tvseries_model.dart';

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

  Future<List<Results>?> fetchUpcomingMovies() async {
    try {
      final response = await Dio().get(ApiConst.upcomingMovies);
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

  Future<Map<String, dynamic>?> fetchMovieDetails(String movieId) async {
    try {
      var uriLink = Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId?api_key=d2ff724b7d35aa2d69624813cb137d8b&language=en-US");
      final response = await http.get(uriLink);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> a =
            Map<String, dynamic>.from(json.decode(response.body));
        return a;
      }
      return null;
    } on DioError catch (e) {
      _ShowDebug.showDioError(e);
    }
    return null;
  }

  Future<List<MovieActorModel>?> fetchMovieActors(String id) async {
    try {
      final response = await Dio().get(
        "https://api.themoviedb.org/3/movie/$id/credits?api_key=d2ff724b7d35aa2d69624813cb137d8b&language=en-US"
      );
      if (response.statusCode == HttpStatus.ok) {
        var data = response.data["cast"];
        if (data is List) {
          return data.map((e) => MovieActorModel.fromJson(e)).toList();
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
