import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yn_flutter/components/blur_background.dart';
import 'package:yn_flutter/components/loading_image.dart';
import 'package:yn_flutter/components/recommend_movie_list.dart';
import 'package:yn_flutter/components/skeleton_container.dart';
import 'package:yn_flutter/models/cast.dart';
import 'package:yn_flutter/models/movie.dart';
import 'package:yn_flutter/models/recommend_movie.dart';
import 'package:yn_flutter/network/tmdb_api.dart';

class DetailPage extends StatefulWidget {
  final Movie? movie;
  final RecommendMovie? recommendMovie;
  final String tag;
  const DetailPage(
      {Key? key, this.movie, this.recommendMovie, required this.tag})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var api = TMDB_API();
  List<RecommendMovie>? recommendedMovieList;
  List<Cast>? castsList;

  @override
  void initState() {
    super.initState();
    var movieId =
        widget.movie != null ? widget.movie!.id : widget.recommendMovie!.id;
    api.getCast(movieId).then((value) {
      setState(() {
        castsList = value;
      });
    });

    api.getRecommendedMovies(movieId).then((value) {
      setState(() {
        recommendedMovieList = value;
        print("recommendedMovieList length: ${recommendedMovieList?.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic movie =
        widget.movie != null ? widget.movie! : widget.recommendMovie!;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Stack(
        children: [
          BlurBackground(
            backdropPath: movie.backdropPath,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _movieInformation(movie),
                const SizedBox(height: 12),
                _recommendMovieList(),
                const SizedBox(height: 12),
                castsList == null
                    ? const CircularProgressIndicator()
                    : _castInformation(movie)
              ],
            ),
          )
        ],
      ),
    );
  }

  _movieInformation(movie) {
    return Column(
      children: [
        Hero(
          tag: widget.tag,
          child: LoadingImage(imagePath: movie.posterPath),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(movie.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 14,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            movie.overview,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  _castInformation(movie) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: castsList!.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Cast c = castsList![index];
        print(c.profilePath);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: c.profilePath == null
                    ? "https://via.placeholder.com/150/00ced1/FFFFFF?text=TMDB"
                    : TMDB_API.imageURL + c.profilePath!,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 25,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => const SkeletonContainer.circular(
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.originalName,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      c.character!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _recommendMovieList() {
    return recommendedMovieList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RecommendMovieList(
            title: "Recommended Movies", mList: recommendedMovieList!);
  }
}
