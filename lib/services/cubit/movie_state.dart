part of 'movie_cubit.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {
  MovieLoading();
}

class StartAllServices extends MovieState {
  final List<Results>? trendingMoviesCubitList;
  final List<Results>? popularMovieCubitList;

  StartAllServices(this.trendingMoviesCubitList, this.popularMovieCubitList);
}

class GetTrendingMovieState extends MovieState {
  final List<Results>? trendingMoviesCubitList;
  GetTrendingMovieState(this.trendingMoviesCubitList);
}

class GetPopularMovieState extends MovieState {
  final List<Results>? popularMovieCubitList;
  GetPopularMovieState(this.popularMovieCubitList);
}

class UpcomingMovieState extends MovieState {
  final List<TvSeriesResult>? upcomingMovieCubitList;
  UpcomingMovieState(this.upcomingMovieCubitList);
}

class GetMovieDataState extends MovieState {
  final Map<String, dynamic>? movieDetailsModel;
  GetMovieDataState(this.movieDetailsModel);
}
