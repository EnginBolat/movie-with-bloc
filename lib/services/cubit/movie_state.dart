part of 'movie_cubit.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {
  MovieLoading();
}

class GetTrendingMovieState extends MovieState {
  final List<Results>? trendingMoviesCubitList;
  GetTrendingMovieState(this.trendingMoviesCubitList);
}

class GetPopularMovieState extends MovieState {
  final List<Results>? popularMovieCubitList;
  GetPopularMovieState(this.popularMovieCubitList);
}
