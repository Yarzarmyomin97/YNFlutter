import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yn_flutter/models/cast.dart';
import 'package:yn_flutter/models/cast_response.dart';
import 'package:yn_flutter/models/movie_response.dart';
import 'package:yn_flutter/models/movie.dart';
import 'package:yn_flutter/models/recommend_movie.dart';
import 'package:yn_flutter/models/recommend_movie_response.dart';

class TMDB_API {
  final String _baseURL = "https://api.themoviedb.org/3/";
  static const String imageURL = "https://image.tmdb.org/t/p/w200/";
  static const String apiKey = "43947aadcc72e51d71e744b900d5447d";

  Future<List<Movie>> getMovieList(String movieUrl, {String param = ""}) async {
    var url = Uri.parse("$_baseURL$movieUrl?api_key=$apiKey&$param");
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var resp = MovieResponse.fromRawJson(response.body);
      return resp.results;
    } else {
      print(response.statusCode);
      throw Exception("Failed to load Movies");
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    // https://api.themoviedb.org/3/movie/popular?api_key=43947aadcc72e51d71e744b900d5447d
    return getMovieList("movie/popular");
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    // https://api.themoviedb.org/3/movie/now_playing?api_key=43947aadcc72e51d71e744b900d5447d
    return getMovieList("movie/now_playing");
  }

  Future<List<Movie>> searchMovies(String name) async {
    // https://api.themoviedb.org/3/search/movie?api_key=43947aadcc72e51d71e744b900d5447d&query=batman
    return getMovieList("search/movie", param: "query=" + name);
  }

  Future<List<Cast>> getCast(int movieID) async {
    // https://api.themoviedb.org/3/movie/634649/credits?api_key=43947aadcc72e51d71e744b900d5447d
    var castUrl = "movie/$movieID/credits";
    var url = Uri.parse("$_baseURL$castUrl?api_key=$apiKey");
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var resp = CastResponse.fromRawJson(response.body);
      return resp.cast;
    } else {
      print(response.statusCode);
      throw Exception("Failed to load Casts");
    }
  }

  Future<List<RecommendMovie>> getRecommendedMovies(int movieID) async {
    // https://api.themoviedb.org/3/movie/634649/credits?api_key=43947aadcc72e51d71e744b900d5447d
    var castUrl = "movie/$movieID/recommendations";
    var url = Uri.parse("$_baseURL$castUrl?api_key=$apiKey");
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var resp = RecommendMovieResponse.fromRawJson(response.body);
      return resp.results;
    } else {
      print(response.statusCode);
      throw Exception("Failed to load RecommendMovie");
    }
  }
}
