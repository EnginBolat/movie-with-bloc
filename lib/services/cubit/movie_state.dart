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
  final List<Results>? upcomingMovieCubitList;

  StartAllServices(
    this.trendingMoviesCubitList,
    this.popularMovieCubitList,
    this.upcomingMovieCubitList,
  );
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
  final List<Results>? upcomingMovieCubitList;
  UpcomingMovieState(this.upcomingMovieCubitList);
}

class GetMovieDataState extends MovieState {
  final Map<String, dynamic>? movieDetailsModel;
  final List<MovieActorModel>? movieActorModel;
  GetMovieDataState(this.movieDetailsModel, this.movieActorModel);
}

class GetMovieActorsState extends MovieState {
  final List<MovieActorModel>? movieActorModel;
  GetMovieActorsState(this.movieActorModel);
}

class GetActorDetailsState extends MovieState {
  final ActorDetailsModel? actorDetailsItem;
  final List<Results>? movieHistoryList;
  GetActorDetailsState(this.actorDetailsItem, this.movieHistoryList);
}

class GetActorMovieHistoryState extends MovieState {
  final List<Results>? movieHistoryList;
  GetActorMovieHistoryState(this.movieHistoryList);
}
