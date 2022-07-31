import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:q_movies/core/qcolors.dart';

/// The collection of Q typography style definitions.
class QTypography {
  static final header = TextStyle(
    fontWeight: FontWeight.w600,
    color: QColors.white,
    fontSize: 22.sp,
  );

  static final title = TextStyle(
    fontWeight: FontWeight.w600,
    color: QColors.white,
    fontSize: 15.sp,
  );

  static final description = TextStyle(
    fontWeight: FontWeight.w300,
    color: QColors.white,
    fontSize: 13.sp,
  );

  static final caption = TextStyle(
    fontWeight: FontWeight.w400,
    color: QColors.white,
    fontSize: 12.sp,
  );

  static final captionSmall = TextStyle(
    fontWeight: FontWeight.w400,
    color: QColors.white,
    fontSize: 11.sp,
  );
}
