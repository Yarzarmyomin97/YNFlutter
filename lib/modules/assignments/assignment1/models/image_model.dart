import 'dart:ui';

class ImageModel {
  final int id;
  final String image;
  bool clickable;
  Color bgColor;
  Color textColor;

  ImageModel({
    required this.id,
    required this.image,
    required this.clickable,
    required this.bgColor,
    required this.textColor,
  });
}
