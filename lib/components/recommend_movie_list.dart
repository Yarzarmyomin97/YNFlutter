import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yn_flutter/models/recommend_movie.dart';
import 'package:yn_flutter/network/tmdb_api.dart';
import 'package:yn_flutter/pages/detail_page.dart';
import 'skeleton_container.dart';

class RecommendMovieList extends StatefulWidget {
  final String title;
  final List<RecommendMovie> mList;
  const RecommendMovieList({Key? key, required this.mList, required this.title})
      : super(key: key);

  @override
  State<RecommendMovieList> createState() => _RecommendMovieListState();
}

class _RecommendMovieListState extends State<RecommendMovieList> {
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
                  RecommendMovie m = widget.mList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            recommendMovie: m,
                            tag: "RM" + m.id.toString(),
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
                                tag: "RM" + m.id.toString(),
                                child: CachedNetworkImage(
                                  imageUrl: m.posterPath == null
                                      ? "http://via.placeholder.com/200x150"
                                      : TMDB_API.imageURL + m.posterPath!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const SkeletonContainer.rounded(
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
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
