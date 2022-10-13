import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/constants/app_api.dart';
import 'package:movie_app_bloc/services/cubit/movie_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              return _MovieLoading();
            } else if (state is GetTrendingMovieState) {
              return _trendingMoviesList(context, state);
            } else if (state is GetPopularMovieState) {
              return _popularMoviesList(context, state);
            } else {
              return _error();
            }
          },
        ),
      ),
    );
  }

  Text _error() => const Text("error");

  Padding _trendingMoviesList(
      BuildContext context, GetTrendingMovieState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Treding Movies",
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 500,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.trendingMoviesCubitList?.length ?? 0,
                itemBuilder: ((context, index) {
                  var trendingMovieData = state.trendingMoviesCubitList![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            trendingMovieData.title ?? "",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                              height: 250,
                              width: 170,
                              child: Image.network(
                                ApiConst.poster_path +
                                    (trendingMovieData.posterPath ?? ""),
                              )),
                        ),
                      ],
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }

  Padding _popularMoviesList(
      BuildContext context, GetPopularMovieState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Treding Movies",
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 500,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.popularMovieCubitList?.length ?? 0,
                itemBuilder: ((context, index) {
                  var trendingMovieData = state.popularMovieCubitList![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            trendingMovieData.title ?? "",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                              height: 250,
                              width: 170,
                              child: Image.network(
                                ApiConst.poster_path +
                                    (trendingMovieData.posterPath ?? ""),
                              )),
                        ),
                      ],
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }

  Center _MovieLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
