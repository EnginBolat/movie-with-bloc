import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/constants/app_radius.dart';
import 'package:movie_app_bloc/view/actor_details_page.dart';
import 'package:movie_app_bloc/widget/spacer_widget.dart';

import '../constants/app_api.dart';
import '../constants/app_padding.dart';
import '../model/movie_actor_model.dart';
import '../services/cubit/movie_cubit.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key, required this.movieId});
  final String movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieCubit()..getMovieDetails(movieId);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<MovieCubit, MovieState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MovieLoading) {
              return _movieLoading();
            } else if (state is GetMovieDataState) {
              var data = state.movieDetailsModel;
              return _movieDetailsWidget(context, data, state.movieActorModel);
            } else {
              return _error();
            }
          },
        ),
      ),
    );
  }

  SingleChildScrollView _movieDetailsWidget(BuildContext context,
      Map<String, dynamic>? data, List<MovieActorModel>? movieActorList) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(MovieDetailsPageRadius.posterValue),
                bottomRight:
                    Radius.circular(MovieDetailsPageRadius.posterValue),
              ),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    fit: BoxFit.fill,
                    ApiConst.posterPath + (data?["poster_path"] ?? ""),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MoviePagePaddig.minimumValue,
                  vertical: MoviePagePaddig.normalValue),
              child: Column(
                children: [
                  Text(
                    data?["title"],
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SpacerWidget(
                    pageContext: context,
                    coefficient: 0.02,
                  ),
                  // _buildGenresBox(context, data),
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
                  SpacerWidget(pageContext: context, coefficient: 0.05),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movieActorList?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                EdgeInsets.all(MoviePagePaddig.minimumValue),
                            child: Column(
                              children: [
                                Text(
                                  movieActorList?[index].name ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ActorDetailsPage(
                                            id: movieActorList?[index]
                                                    .id
                                                    .toString() ??
                                                ""),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          "lib/assets/images/placeholder.png",
                                      image: ApiConst.posterPath +
                                          (movieActorList?[index].profilePath ??
                                              ""),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                            child: Image.asset(
                                                "lib/assets/images/placeholder.png"));
                                      },
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
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
      borderRadius: BorderRadius.circular(MovieDetailsPageRadius.normalValue),
      child: Container(
        height: MediaQuery.of(context).size.height * .135,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.all(MoviePagePaddig.normalValue),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data?["genres"][0]["name"].toString() ?? "No Genres",
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
