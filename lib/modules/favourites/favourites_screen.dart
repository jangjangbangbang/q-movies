import 'package:flutter/material.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/core/qtypography.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QColors.bgColor,
      body: Center(
        child: Text(
          'Favourites Screen',
          style: QTypography.title,
        ),
      ),
    );
  }
}
