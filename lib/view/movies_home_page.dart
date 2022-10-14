import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/constants/app_api.dart';
import 'package:movie_app_bloc/model/movie_model.dart';
import 'package:movie_app_bloc/services/cubit/movie_cubit.dart';

import 'movie_details_page.dart';

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
            } else if (state is StartAllServices) {
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
      BuildContext context, StartAllServices state) {
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
            height: MediaQuery.of(context).size.height * 0.5,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailsPage(
                                      movieId:
                                          trendingMovieData?.id.toString() ??
                                              ""),
                                ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                                height: 250,
                                width: 170,
                                child: Image.network(
                                  ApiConst.posterPath +
                                      (trendingMovieData?.posterPath ?? ""),
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
  }

  Padding _popularMoviesList(
      BuildContext context, List<Results>? popularMovieList) {
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
            height: MediaQuery.of(context).size.height * 0.5,
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
                                ApiConst.posterPath +
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

  Center _movieLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
