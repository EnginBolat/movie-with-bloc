import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_bloc/model/movie_actor_model.dart';
import 'package:movie_app_bloc/model/movie_model.dart';

import '../../model/actor_details_page.dart';
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
      List<Results>? upcomingMovieModelList =
          await JsonServices().fetchUpcomingMovies();

      Future.delayed(const Duration(seconds: 3));
      emit(StartAllServices(
        trendingMoviesModelList,
        popularMovieModelList,
        upcomingMovieModelList,
      ));
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

  Future<List<Results>?> getUpcomingMovies() async {
    try {
      emit(MovieLoading());
      List<Results>? upcomingMovieList =
          await JsonServices().fetchUpcomingMovies();
      Future.delayed(const Duration(seconds: 3));
      emit(UpcomingMovieState(upcomingMovieList));
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Map<String, dynamic>?> getMovieDetails(String movieId) async {
    try {
      emit(MovieLoading());
      Map<String, dynamic>? popularMoviesModelList =
          await JsonServices().fetchMovieDetails(movieId);
      List<MovieActorModel>? movieActorModelList =
          await JsonServices().fetchMovieActors(movieId);
      Future.delayed(const Duration(seconds: 3));
      emit(GetMovieDataState(popularMoviesModelList, movieActorModelList));
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<MovieActorModel>?> getMovieActors(String id) async {
    try {
      emit(MovieLoading());
      List<MovieActorModel>? movieActorModelList =
          await JsonServices().fetchMovieActors(id);
      Future.delayed(const Duration(seconds: 3));
      emit(GetMovieActorsState(movieActorModelList));
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ActorDetailsModel?> getActorDetails(String id) async {
    try {
      emit(MovieLoading());
      ActorDetailsModel? modelItem = await JsonServices().fetchActorDetails(id);
      List<Results>? historyList =
          await JsonServices().fetchActorMovieHistory(id);
      Future.delayed(const Duration(seconds: 3));
      emit(GetActorDetailsState(modelItem, historyList));
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Results>?> getActorMovieHistory(String id) async {
    try {
      emit(MovieLoading());
      List<Results>? historyList =
          await JsonServices().fetchActorMovieHistory(id);
      Future.delayed(const Duration(seconds: 3));
      emit(GetActorMovieHistoryState(historyList));
    } catch (e) {
      print(e);
    }
    return null;
  }
}
