import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/services/cubit/movie_cubit.dart';
import 'package:movie_app_bloc/widget/movies_list.dart';
import 'package:movie_app_bloc/widget/spacer_widget.dart';
import 'package:movie_app_bloc/widget/tv_series_list.dart';

class TvSeriesHomePage extends StatelessWidget {
  const TvSeriesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit()..StartallTvSeriesService(),
      child: Scaffold(
          appBar: AppBar(),
          body: BlocConsumer<MovieCubit, MovieState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is MovieLoading) {
                return _buildLoading();
              } else if (state is StartAllTvSeriesServiceState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TvSeriesList(
                          title: "Popular",
                          tvSeriesDetailsList: state.popularTvSeriesList),
                      SpacerWidget(pageContext: context, coefficient: 0.1),
                      TvSeriesList(
                          title: "Trending",
                          tvSeriesDetailsList: state.trendingTvSeriesList),
                    ],
                  ),
                );
              } else {
                return _buildError();
              }
            },
          )),
    );
  }

  Center _buildError() {
    return const Center(
      child: Text("error"),
    );
  }

  Center _buildLoading() => const Center(
        child: CircularProgressIndicator(),
      );
}
