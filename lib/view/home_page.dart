import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/constants/app_api.dart';
import 'package:movie_app_bloc/model/trending_movies_model.dart';
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
            } else if (state is StartAllServices) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _trendingMoviesList(
                      context,
                      state.trendingMoviesCubitList,
                    ),
                    _popularMoviesList(
                      context,
                      state.popularMovieCubitList,
                    ),
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

  Padding _trendingMoviesList(
      BuildContext context, List<Results>? trendingMovieList) {
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
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trendingMovieList?.length ?? 0,
                itemBuilder: ((context, index) {
                  var trendingMovieData = trendingMovieList?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            trendingMovieData?.title ?? "",
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
                                    (trendingMovieData?.posterPath ?? ""),
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

  Padding _popularMoviesList(BuildContext context, List<Results>? popularMovieList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular Movies",
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,

            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularMovieList?.length ?? 0,
                itemBuilder: ((context, index) {
                  var trendingMovieData = popularMovieList?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            trendingMovieData?.title ?? "",
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
                                    (trendingMovieData?.posterPath ?? ""),
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
