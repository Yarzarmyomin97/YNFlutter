import 'package:flutter/material.dart';
import 'package:yn_flutter/components/search_list.dart';
import 'package:yn_flutter/models/movie.dart';
import 'package:yn_flutter/network/tmdb_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var movieAPI = TMDB_API();
  List<Movie> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          print(value);
          movieAPI.searchMovies(value).then((value) {
            setState(() {
              searchResult = value;
            });
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      )),
      body: searchResult.isEmpty
          ? Center(
              child: Text(
              "Search Movies",
              style: Theme.of(context).textTheme.headline6,
            ))
          : SearchList(
              mList: searchResult,
            ),
    );
  }
}
