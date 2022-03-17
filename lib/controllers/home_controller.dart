import 'package:get/get.dart';
import 'package:yn_flutter/models/movie.dart';
import 'package:yn_flutter/network/tmdb_api.dart';

class HomeController extends GetxController {
  RxList<Movie> popularMovies = <Movie>[].obs;
  RxList<Movie> nowPlayingMovies = <Movie>[].obs;

  loadPopular() {
    TMDB_API().getPopularMovies().then((value) => popularMovies.value = value);
  }

  loadNowPlaying() {
    TMDB_API()
        .getNowPlayingMovies()
        .then((value) => nowPlayingMovies.value = value);
  }
}
