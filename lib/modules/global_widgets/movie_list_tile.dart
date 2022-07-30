import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/core/qtypography.dart';
import 'package:q_movies/modules/global_widgets/genre_widget.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    super.key,
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
    required this.genreIdList,
    required this.genreNameList,
  });
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final List<int> genreIds;
  final List<int> genreIdList;
  final List<String> genreNameList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: InkWell(
        onTap: () {},
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
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _moviePoster() {
    return SizedBox(
      height: 100.h,
      width: 100.h,
      // color: Colors.blue,
      child: Image.network(
        'https://image.tmdb.org/t/p/w500/$posterPath',
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Expanded _movieDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
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
                '$voteAverage / 10 IMDb',
                style: QTypography.caption,
              )
            ],
          ),
          SizedBox(height: 12.h),
          ConstrainedBox(
            constraints: const BoxConstraints(),
            child: SingleChildScrollView(
              child: Wrap(
                children: genreIds.map((i) {
                  for (var index = 0; index < genreIdList.length; index++) {
                    if (i == genreIdList[index]) {
                      return GenreWidget(text: genreNameList[index]);
                    }
                  }
                  return GenreWidget(text: i.toString());
                }).toList(),
                // genreIds
                //     .map((i) => GenreWidget(text: i.toString()))
                //     .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
