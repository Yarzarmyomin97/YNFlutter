import 'dart:convert';

import 'recommend_movie.dart';

class RecommendMovieResponse {
  RecommendMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<RecommendMovie> results;
  int totalPages;
  int totalResults;

  factory RecommendMovieResponse.fromRawJson(String str) =>
      RecommendMovieResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecommendMovieResponse.fromJson(Map<String, dynamic> json) =>
      RecommendMovieResponse(
        page: json["page"],
        results: List<RecommendMovie>.from(
            json["results"].map((x) => RecommendMovie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
