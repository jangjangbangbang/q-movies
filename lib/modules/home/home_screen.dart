import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/core/qtypography.dart';
import 'package:q_movies/modules/home/local_widget/favourites_tab.dart';
import 'package:q_movies/modules/home/home_controller.dart';
import 'package:q_movies/modules/home/local_widget/movies_tab.dart';

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/img-logo.svg',
                      fit: BoxFit.fitHeight,
                      height: 24.h,
                    ),
                    Obx(
                      () => controller.hasInternet.value
                          ? TextButton(
                              onPressed: () {
                                if (controller.hasInternet.value) {
                                  controller.refreshData();
                                }
                              },
                              style:
                                  TextButton.styleFrom(primary: QColors.white),
                              child: Text(
                                'Refresh',
                                style: QTypography.title.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Row(
                              children: [
                                Container(
                                  height: 8.h,
                                  width: 8.h,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white38,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Offline',
                                  style: QTypography.title.copyWith(
                                    color: Colors.white38,
                                  ),
                                )
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ),
            body: const TabBarView(
              children: [
                MoviesTab(),
                FavouritesTab(),
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
