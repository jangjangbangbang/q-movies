import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/core/qtypography.dart';
import 'package:q_movies/modules/favourites/favourites_screen.dart';
import 'package:q_movies/modules/home/home_controller.dart';
import 'package:q_movies/modules/movies/movies_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: QColors.bgColor,
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: QColors.bgColor,
            appBar: AppBar(
              backgroundColor: QColors.bgColor,
              elevation: 0,
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/img-logo.svg',
                      fit: BoxFit.fitHeight,
                      height: 24.h,
                    )
                  ],
                ),
              ),
            ),
            body: const TabBarView(
              children: [
                MoviesScreen(),
                FavouritesScreen(),
              ],
            ),
            bottomNavigationBar: ColoredBox(
              color: QColors.navColor,
              child: TabBar(
                labelColor: QColors.primary,
                unselectedLabelColor: QColors.white,
                labelStyle: QTypography.caption.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2,
                    color: QColors.primary,
                  ),
                  insets: EdgeInsets.fromLTRB(40, 0, 40, 46),
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(
                        //   'assets/icons/movie.svg',
                        //   fit: BoxFit.fitWidth,
                        //   width: 24.w,
                        // ),
                        const Icon(Icons.movie_creation_outlined),
                        SizedBox(width: 8.w),
                        const Text('Movies'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.bookmark_added_outlined),
                        SizedBox(width: 8.w),
                        const Text('Favourites'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
