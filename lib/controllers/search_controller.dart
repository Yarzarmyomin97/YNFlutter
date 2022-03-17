import 'package:get/get.dart';
import 'package:yn_flutter/models/movie.dart';
import 'package:yn_flutter/network/tmdb_api.dart';

class SearchController extends GetxController {
  RxList<Movie> searchResults = <Movie>[].obs;

  searchMovie(name) {
    TMDB_API().searchMovies(name).then((value) => searchResults.value = value);
  }
}
