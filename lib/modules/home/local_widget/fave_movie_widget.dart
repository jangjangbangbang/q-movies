// ignore_for_file: inference_failure_on_function_invocation

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/core/qtypography.dart';
import 'package:q_movies/models/movie.dart';
import 'package:q_movies/modules/global_widgets/genre_widget.dart';
import 'package:q_movies/modules/global_widgets/q_loader.dart';
import 'package:q_movies/modules/home/home_controller.dart';
import 'package:q_movies/routes/app_pages.dart';
import 'package:q_movies/utils/boxes.dart';

class FaveMovieWidget extends StatelessWidget {
  const FaveMovieWidget({
    super.key,
    required this.movie,
    required this.allGenreIds,
    required this.allGenreNames,
    required this.isFavourite,
    required this.index,
  });
  final Movie movie;
  final List<int> allGenreIds;
  final List<String> allGenreNames;
  final bool isFavourite;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final boxController = Get.put<BoxController>(BoxController());
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            Routes.MOVIE_DETAILS_SCREEN,
            arguments: [
              {
                'movie': Movie(
                  id: movie.id + 5264,
                  title: movie.title,
                  overview: movie.overview,
                  posterPath: movie.posterPath,
                  voteAverage: movie.voteAverage,
                  genreIds: movie.genreIds,
                ),
                'allGenreIds': allGenreIds,
                'allGenreNames': allGenreNames,
                'isBookmarked': true,
                'fromFave': true,
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
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
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
                            ],
                          ),
                        ),
                        SizedBox(width: 14.w),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: InkWell(
                            onTap: () {
                              boxController.removeFromFavourites(
                                movie: movie,
                              );

                              controller
                                ..removeBookmark(id: movie.id)
                                ..refreshData();
                            },
                            borderRadius: BorderRadius.circular(20),
                            splashColor: QColors.splashColor,
                            highlightColor: QColors.splashColor,
                            child: const Icon(
                              Icons.bookmark_added,
                              color: QColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      child: SizedBox(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Wrap(
                              children: movie.genreIds.map((i) {
                                for (var index = 0;
                                    index < allGenreIds.length;
                                    index++) {
                                  if (i == allGenreIds[index]) {
                                    return GenreWidget(
                                      text: allGenreNames[index],
                                    );
                                  }
                                }
                                return GenreWidget(text: i.toString());
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _moviePoster() {
    return Hero(
      tag: movie.id + 5264,
      child: CachedNetworkImage(
        imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
        fit: BoxFit.fitWidth,
        height: 100.h,
        width: 100.h,
        placeholder: (context, url) => const Center(
          child: QLoader(),
        ),
        errorWidget: (context, url, error) => Center(
          child: SizedBox(
            height: 50.h,
            width: 50.h,
            child: SvgPicture.asset(
              'assets/icons/img-logo.svg',
              color: QColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
