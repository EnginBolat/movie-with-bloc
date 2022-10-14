import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/services/json_services/json_services.dart';
import 'package:movie_app_bloc/widget/spacer_widget.dart';

import '../constants/app_api.dart';
import '../services/cubit/movie_cubit.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.movieId});
  final String movieId;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Map<String, dynamic>? modelList;

  Future<void> transferData() async {
    modelList = await JsonServices().fetchMovieDetails(widget.movieId);
  }

  @override
  void initState() {
    super.initState();
    transferData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit()..getMovieDetails(widget.movieId),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<MovieCubit, MovieState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MovieLoading) {
              return _movieLoading();
            } else if (state is GetMovieDataState) {
              var data = state.movieDetailsModel;
              return _movieDetailsWidget(context, data);
            } else {
              return _error();
            }
          },
        ),
      ),
    );
  }

  SingleChildScrollView _movieDetailsWidget(
      BuildContext context, Map<String, dynamic>? data) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              child: SizedBox(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    fit: BoxFit.fill,
                    ApiConst.posterPath + (data?["poster_path"] ?? ""),
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
              child: Column(
                children: [
                  Text(
                    data?["title"],
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SpacerWidget(
                    pageContext: context,
                    coefficient: 0.02,
                  ),
                  _buildGenresBox(context, data),
                  SpacerWidget(pageContext: context, coefficient: 0.05),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Overview",
                        style: Theme.of(context).textTheme.headline3,
                      )),
                  SpacerWidget(pageContext: context, coefficient: 0.02),
                  Text(
                    data?["overview"],
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect _buildGenresBox(BuildContext context, Map<String, dynamic>? data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: MediaQuery.of(context).size.height * .135,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data?["genres"][0]["name"] ?? "No Genres",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    "⭐️ ${data?["vote_average"].toString() ?? "0.0"}",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        ),
                  )
                ],
              ),
              SpacerWidget(pageContext: context, coefficient: 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data?["genres"][1]["name"] ?? "No Genres",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
              SpacerWidget(pageContext: context, coefficient: 0.01),
            ],
          ),
        ),
      ),
    );
  }
}

Center _movieLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Center _error() {
  return const Center(
    child: Text("Error"),
  );
}
