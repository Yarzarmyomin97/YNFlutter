import 'package:flutter/material.dart';
import 'package:yn_flutter/modules/assignments/assignment1/models/image_model.dart';

class ImageItem extends StatelessWidget {
  final Function()? onTap;
  final ImageModel imageModel;
  const ImageItem({Key? key, required this.onTap, required this.imageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: imageModel.bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          imageModel.image,
          color: imageModel.textColor,
          width: 100,
          height: 100,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
