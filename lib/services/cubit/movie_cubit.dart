import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_bloc/model/trending_movies_model.dart';

import '../../constants/app_api.dart';
import '../json_services/json_services.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());

  void startAll() {
    getTrendingMoviesCubit();
    getPopularMoviesCubit();
  }

  Future<List<Results>?> getTrendingMoviesCubit() async {
    try {
      emit(MovieLoading());
      List<Results>? trendingMoviesModelList =
          await JsonServices().fetchTrendingMovies();
      Future.delayed(const Duration(seconds: 3));
      emit(GetTrendingMovieState(trendingMoviesModelList));
    } catch (e) {
      print("GetMoviesCubit Patladı Hocam");
    }
    return null;
  }

  Future<List<Results>?> getPopularMoviesCubit() async {
    try {
      emit(MovieLoading());
      List<Results>? popularMoviesModelList =
          await JsonServices().fetchTrendingMovies();
      Future.delayed(const Duration(seconds: 3));
      emit(GetTrendingMovieState(popularMoviesModelList));
    } catch (e) {
      print("getPopularMoviesCubit Patladı Hocam");
    }
    return null;
  }
}
