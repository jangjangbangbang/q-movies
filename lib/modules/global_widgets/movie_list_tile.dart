// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/core/qtypography.dart';
import 'package:q_movies/models/genre.dart';
import 'package:q_movies/models/movie.dart';
import 'package:q_movies/modules/global_widgets/genre_widget.dart';
import 'package:q_movies/routes/app_pages.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    super.key,
    required this.movie,
    required this.allGenreIds,
    required this.allGenreNames,
  });
  final Movie movie;
  final List<int> allGenreIds;
  final List<String> allGenreNames;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            Routes.MOVIE_DETAILS_SCREEN,
            arguments: [
              {
                'movie': movie,
                'allGenreIds': allGenreIds,
                'allGenreNames': allGenreNames,
              }
            ],
          );
        },
        splashColor: QColors.splashColor,
        highlightColor: QColors.splashColor,
        borderRadius: BorderRadius.circular(4.r),
        child: SizedBox(
          height: 100.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _moviePoster(),
              SizedBox(width: 16.w),
              _movieDetails(),
              SizedBox(width: 14.w),
              _bookmark(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _bookmark() {
    return SizedBox(
      height: 30,
      width: 30,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        splashColor: QColors.splashColor,
        highlightColor: QColors.splashColor,
        child: Icon(
          Icons.bookmark_outline,
          color: QColors.white,
        ),
      ),
    );
  }

  Widget _moviePoster() {
    return SizedBox(
      height: 100.h,
      width: 100.h,
      // color: Colors.blue,
      child: Hero(
        tag: movie.id,
        child: Image.network(
          'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Expanded _movieDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: QTypography.title.copyWith(height: 1.5),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                Icons.star,
                color: QColors.secondary,
                size: 14.w,
              ),
              SizedBox(width: 4.w),
              Text(
                '${movie.voteAverage} / 10 IMDb',
                style: QTypography.caption,
              )
            ],
          ),
          SizedBox(height: 12.h),
          ConstrainedBox(
            constraints: const BoxConstraints(),
            child: SingleChildScrollView(
              child: Wrap(
                children: movie.genreIds.map((i) {
                  for (var index = 0; index < allGenreIds.length; index++) {
                    if (i == allGenreIds[index]) {
                      return GenreWidget(text: allGenreNames[index]);
                    }
                  }
                  return GenreWidget(text: i.toString());
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
