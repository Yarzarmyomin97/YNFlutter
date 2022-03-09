import 'dart:convert';
import 'package:yn_flutter/models/movie.dart';

class ResultPopular {
  ResultPopular({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory ResultPopular.fromRawJson(String str) =>
      ResultPopular.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultPopular.fromJson(Map<String, dynamic> json) => ResultPopular(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
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
