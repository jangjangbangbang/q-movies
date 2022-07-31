import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/core/qtypography.dart';
import 'package:q_movies/models/movie.dart';
import 'package:q_movies/modules/global_widgets/genre_widget.dart';
import 'package:q_movies/modules/movie_details/movie_details_controller.dart';

class MovieDetailsScreen extends GetView<MovieDetailsController> {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = controller.movie;
    return ColoredBox(
      color: QColors.bgColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: QColors.bgColor,
          body: Stack(
            children: [
              _moviePoster(movie),
              Column(
                children: [
                  _blankSpaceAndBackButton(),
                  _movieDescription(movie)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _blankSpaceAndBackButton() {
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: Align(
        alignment: Alignment.topLeft,
        child: RotatedBox(
          quarterTurns: 2,
          child: SlideInRight(
            duration: const Duration(milliseconds: 800),
            child: IconButton(
              // ignore: inference_failure_on_generic_invocation
              onPressed: Get.back,
              icon: const Icon(
                Icons.arrow_right_alt,
                color: QColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Hero _moviePoster(Movie movie) {
    return Hero(
      tag: controller.movie.id,
      child: CachedNetworkImage(
        imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
        fit: BoxFit.fitWidth,
        height: 334.h,
        width: double.infinity,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Expanded _movieDescription(Movie movie) {
    return Expanded(
      child: FadeInUp(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: QColors.bgColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 16.w,
                  left: 20.w,
                  right: 4.w,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        movie.title,
                        style: QTypography.header.copyWith(height: 1.5),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        height: 54.h,
                        width: 54.h,
                        child: InkWell(
                          splashColor: QColors.splashColor,
                          highlightColor: QColors.splashColor,
                          borderRadius: BorderRadius.circular(99),
                          onTap: () {},
                          child: const Icon(
                            Icons.bookmark_border,
                            color: QColors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(height: 16.h),
                    Wrap(
                      children: movie.genreIds.map((i) {
                        for (var index = 0;
                            index < controller.allGenreIds.length;
                            index++,) {
                          if (i == controller.allGenreIds[index]) {
                            return GenreWidget(
                              text: controller.allGenreNames[index],
                            );
                          }
                        }
                        return GenreWidget(text: i.toString());
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: QTypography.header,
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: ListView(
                          children: [
                            Text(
                              movie.overview,
                              style:
                                  QTypography.description.copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
