import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yn_flutter/components/movie_list.dart';
import 'package:yn_flutter/models/movie.dart';
import 'package:yn_flutter/network/tmdb_api.dart';
import 'package:yn_flutter/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> popularMovieList = [];
  List<Movie> nowPlayingMovieList = [];

  @override
  void initState() {
    super.initState();
    loadMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Column(
          children: [
            nowPlayingMovieList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : MovieList(title: "Now Playing", mList: nowPlayingMovieList),
            popularMovieList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : MovieList(title: "Popular", mList: popularMovieList),
          ],
        ));
  }

  void loadMovie() {
    TMDB_API().getPopularMovies().then((value) {
      setState(() {
        popularMovieList = value;
        print("popularMovieList length: ${popularMovieList.length}");
      });
    });

    TMDB_API().getNowPlayingMovies().then((value) {
      setState(() {
        nowPlayingMovieList = value;
        print("nowPlayingMovieList length: ${nowPlayingMovieList.length}");
      });
    });
  }
}
