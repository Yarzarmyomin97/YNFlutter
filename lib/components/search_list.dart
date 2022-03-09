import 'package:flutter/material.dart';
import 'package:yn_flutter/models/movie.dart';
import 'package:yn_flutter/network/tmdb_api.dart';

class SearchList extends StatefulWidget {
  final List<Movie> mList;
  const SearchList({Key? key, required this.mList}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: ListView.separated(
        itemCount: widget.mList.length,
        itemBuilder: (BuildContext context, int index) {
          Movie m = widget.mList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    child: Image.network(
                      m.posterPath == null
                          ? "http://via.placeholder.com/200x150"
                          : TMDB_API.imageURL + m.posterPath!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Text(
                          m.title,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Text(
                          m.overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 5),
      ),
    );
  }
}
