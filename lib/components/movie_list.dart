import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yn_flutter/models/movie.dart';
import 'package:yn_flutter/network/tmdb_api.dart';
import 'package:yn_flutter/pages/detail_page.dart';
import 'loading_image.dart';
import 'skeleton_container.dart';

class MovieList extends StatefulWidget {
  final String tag;
  final String title;
  final List<Movie> mList;
  const MovieList(
      {Key? key, required this.tag, required this.mList, required this.title})
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
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
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
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            movie: m,
                            tag: "${widget.tag}${m.id}",
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 125,
                      height: 200,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(children: [
                          SizedBox(
                            height: 180,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              child: Hero(
                                tag: "${widget.tag}${m.id}",
                                child: LoadingImage(imagePath: m.posterPath),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  m.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
