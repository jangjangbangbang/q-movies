import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/core/qtypography.dart';

class GenreWidget extends StatelessWidget {
  const GenreWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.w, bottom: 4.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: QColors.primary.withOpacity(0.2),
        ),
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
        child: Text(
          text,
          style: QTypography.captionSmall,
        ),
      ),
    );
  }
}
