import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/core/qtypography.dart';
import 'package:q_movies/modules/global_widgets/movie_list_tile.dart';
import 'package:q_movies/modules/movies/movies_controller.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen>
    with AutomaticKeepAliveClientMixin<MoviesScreen> {
  @override
  bool get wantKeepAlive => true;

  final controller = Get.find<MoviesController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ColoredBox(
      color: QColors.bgColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: QColors.bgColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Popular',
                  style: QTypography.header,
                ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => Expanded(
                  child: controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: QColors.primary,
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.movies.length,
                          itemBuilder: (context, index) {
                            final movie = controller.movies[index];

                            return Column(
                              children: [
                                MovieListTile(
                                  movie: movie,
                                  allGenreIds: controller.allGenreIds,
                                  allGenreNames: controller.allGenreNames,
                                ),
                                if (index == controller.movies.length - 1)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: Text(
                                      'Load more',
                                      style: QTypography.title.copyWith(
                                        color: QColors.white.withOpacity(0.6),
                                      ),
                                    ),
                                  )
                              ],
                            );
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
