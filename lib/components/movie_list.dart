import 'package:flutter/material.dart';
import 'package:yn_flutter/models/movie.dart';
import 'package:yn_flutter/network/tmdb_api.dart';

class MovieList extends StatefulWidget {
  final String title;
  final List<Movie> mList;
  const MovieList({Key? key, required this.mList, required this.title})
      : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.mList.length,
                itemBuilder: (BuildContext context, int index) {
                  Movie m = widget.mList[index];
                  return SizedBox(
                    width: 125,
                    height: 217,
                    child: Card(
                      child: Column(children: [
                        SizedBox(
                          height: 180,
                          child: Image.network(m.posterPath == null
                              ? "http://via.placeholder.com/200x150"
                              : TMDB_API.imageURL + m.posterPath!),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              m.title,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      ]),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
