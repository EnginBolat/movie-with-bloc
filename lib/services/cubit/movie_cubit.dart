import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_bloc/model/movie_model.dart';

import '../json_services/json_services.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());

  Future<List<Results>?> startAll() async {
    try {
      emit(MovieLoading());
      List<Results>? popularMovieModelList =
          await JsonServices().fetchPopularMovies();
      List<Results>? trendingMoviesModelList =
          await JsonServices().fetchTrendingMovies();
      Future.delayed(const Duration(seconds: 3));
      emit(StartAllServices(trendingMoviesModelList, popularMovieModelList));
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<Results>?> getTrendingMoviesCubit() async {
    try {
      emit(MovieLoading());
      List<Results>? trendingMoviesModelList =
          await JsonServices().fetchTrendingMovies();
      Future.delayed(const Duration(seconds: 3));
      emit(GetTrendingMovieState(trendingMoviesModelList));
    } catch (e) {
      return null;
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
      return null;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getMovieDetails(String movieId) async {
    try {
      emit(MovieLoading());
      Map<String, dynamic>? popularMoviesModelList =
          await JsonServices().fetchMovieDetails(movieId);
      Future.delayed(const Duration(seconds: 3));
      emit(GetMovieDataState(popularMoviesModelList));
    } catch (e) {
      print(e);
    }
    return null;
  }
}
