import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yn_flutter/network/tmdb_api.dart';

import 'skeleton_container.dart';

class LoadingImage extends StatelessWidget {
  final String? imagePath;
  const LoadingImage({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath == null
          ? "http://via.placeholder.com/200x150"
          : TMDB_API.imageURL + imagePath!,
      fit: BoxFit.cover,
      placeholder: (context, url) => const SkeletonContainer.rounded(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
