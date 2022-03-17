import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yn_flutter/components/search_list.dart';
import 'package:yn_flutter/controllers/search_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // var movieAPI = TMDB_API();
  // List<Movie> searchResult = [];
  final SearchController sc = Get.put(SearchController());

  Widget _searchResultList() => sc.searchResults.isEmpty
      ? Center(
          child: Text(
          "Search Movies",
          style: Theme.of(context).textTheme.headline6,
        ))
      : SearchList(
          mList: sc.searchResults,
        );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SizedBox(
        height: 50,
        child: TextField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            print(value);
            sc.searchMovie(value);
            // movieAPI.searchMovies(value).then((value) {
            //   setState(() {
            //     searchResult = value;
            //   });
            // });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none),
            hintText: "Search",
            suffixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      )),
      body: Obx(
        () {
          return _searchResultList();
        },
      ),
    );
  }
}
