import 'dart:io';

import 'package:flutter/material.dart';

class ImageElement extends StatelessWidget {
  const ImageElement({required this.imagePath, this.width});
  final String imagePath;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: imagePath,
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.fill,
                  ),
                )),
          )),
    );
  }
}
