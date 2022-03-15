import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yn_flutter/network/tmdb_api.dart';

class BlurBackground extends StatelessWidget {
  final String? backdropPath;
  const BlurBackground({Key? key, this.backdropPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(backdropPath == null
                  ? "http://via.placeholder.com/300x350"
                  : TMDB_API.imageURL + backdropPath!),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }
}
