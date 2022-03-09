import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yn_flutter/models/dataResult.dart';
import 'package:yn_flutter/models/movie.dart';

class TMDB_API {
  final String _baseURL = "https://api.themoviedb.org/3/";
  static const String imageURL = "https://image.tmdb.org/t/p/w200/";
  static const String apiKey = "43947aadcc72e51d71e744b900d5447d";

  Future<List<Movie>> getMovieList(String movieUrl, {String param = ""}) async {
    // var url = Uri.parse(_baseURL + movieUrl + "?api_key=" + apiKey + param);
    var url = Uri.parse("$_baseURL$movieUrl?api_key=$apiKey&$param");
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var resp = ResultPopular.fromRawJson(response.body);
      return resp.results;
    } else {
      print(response.statusCode);
      throw Exception("Failed to load Movies");
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    return getMovieList("movie/popular");
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    return getMovieList("movie/now_playing");
  }

  Future<List<Movie>> searchMovies(String name) async {
    return getMovieList("search/movie", param: "query=" + name);
  }
}
