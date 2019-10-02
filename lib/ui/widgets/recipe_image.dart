import 'package:flutter/material.dart';

class RecipeImage extends StatelessWidget {
  final String img;

  RecipeImage(this.img);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Image.asset(
        'assets/'+img,
        fit: BoxFit.cover,
      ),
    );
  }
}
