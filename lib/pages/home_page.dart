import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yn_flutter/components/movie_list.dart';
import 'package:yn_flutter/controllers/home_controller.dart';
import 'package:yn_flutter/pages/search_page.dart';
import 'package:yn_flutter/pages/signin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Movie> popularMovieList = [];
  // List<Movie> nowPlayingMovieList = [];
  final HomeController c = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    c.loadPopular();
    c.loadNowPlaying();
  }

  Widget _popularList() => c.popularMovies.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : MovieList(
          mList: c.popularMovies,
          tag: "P",
          title: "Popular",
        );

  Widget _nowPlayingList() => c.nowPlayingMovies.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : MovieList(
          mList: c.nowPlayingMovies,
          tag: "NP",
          title: "Now Playing",
        );

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
                      builder: (context) => const SearchPage(),
                      fullscreenDialog: true));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.off(() => const SignInPage());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Obx(() {
        return Column(children: [
          _nowPlayingList(),
          _popularList(),
        ]);
      }),
    );
  }

  // void loadMovie() {
  //   TMDB_API().getPopularMovies().then((value) {
  //     setState(() {
  //       popularMovieList = value;
  //       print("popularMovieList length: ${popularMovieList.length}");
  //     });
  //   });

  //   TMDB_API().getNowPlayingMovies().then((value) {
  //     setState(() {
  //       nowPlayingMovieList = value;
  //       print("nowPlayingMovieList length: ${nowPlayingMovieList.length}");
  //     });
  //   });
  // }
}
