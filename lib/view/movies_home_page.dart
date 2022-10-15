import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/services/cubit/movie_cubit.dart';

import '../constants/app_padding.dart';
import '../constants/app_text.dart';
import '../widget/movies_list.dart';

class MoviesHomePage extends StatelessWidget {
  const MoviesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit()..startAll(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<MovieCubit, MovieState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MovieLoading) {
              return _movieLoading();
            } else if (state is StartAllMovieServices) {
              return _homePageMainWidget(context, state);
            } else {
              return _error();
            }
          },
        ),
      ),
    );
  }

  SingleChildScrollView _homePageMainWidget(
      BuildContext context, StartAllMovieServices state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MovieHomePagePadding.minimumValue),
            child: MovieList(
              title: MovieHomePage.trendingMoviesText,
              movieDetailsList: state.trendingMoviesCubitList,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MovieHomePagePadding.minimumValue),
            child: MovieList(
              title: MovieHomePage.popularMoviesText,
              movieDetailsList: state.popularMovieCubitList,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MovieHomePagePadding.minimumValue),
            child: MovieList(
              title: MovieHomePage.upcomingMoviesText,
              movieDetailsList: state.upcomingMovieCubitList,
            ),
          ),
        ],
      ),
    );
  }

  Text _error() => const Text("error");

  Center _movieLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
