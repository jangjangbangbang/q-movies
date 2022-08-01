import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/core/qtypography.dart';
import 'package:q_movies/models/movie.dart';
import 'package:q_movies/modules/home/home_controller.dart';
import 'package:q_movies/modules/home/local_widget/fave_movie_widget.dart';
import 'package:q_movies/utils/boxes.dart';

class FavouritesTab extends StatefulWidget {
  const FavouritesTab({super.key});

  @override
  State<FavouritesTab> createState() => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab>
    with AutomaticKeepAliveClientMixin<FavouritesTab> {
  @override
  bool get wantKeepAlive => true;

  final controller = Get.find<HomeController>();

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
                  'Favourites',
                  style: QTypography.header,
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ValueListenableBuilder<Box<Movie>>(
                  valueListenable: Boxes.getFavourites().listenable(),
                  builder: (context, box, _) {
                    final movies = box.values.toList().cast<Movie>();

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];

                        return FaveMovieWidget(
                          movie: movie,
                          allGenreIds: controller.allGenreIds,
                          allGenreNames: controller.allGenreNames,
                          isFavourite: controller.isFaveMovieList[index],
                          index: index,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
