import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_api.dart';
import '../services/cubit/movie_cubit.dart';

class TvSeriesHomePage extends StatelessWidget {
  const TvSeriesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit()..getUpcomingMovies(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<MovieCubit, MovieState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MovieLoading) {
              return _movieLoading();
            } else if (state is UpcomingMovieState) {
              var upcomingMovies = state.upcomingMovieCubitList;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Treding Movies",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: upcomingMovies?.length ?? 0,
                          itemBuilder: ((context, index) {
                            var trendingMovieData = upcomingMovies?[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      trendingMovieData?.name ?? "",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                          height: 250,
                                          width: 170,
                                          child: Image.network(
                                            ApiConst.posterPath +
                                                (trendingMovieData?.posterPath ??
                                                    ""),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })),
                    )
                  ],
                ),
              );
            } else {
              return _error();
            }
          },
        ),
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
