import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:shimmer/shimmer.dart';

class QLoader extends StatelessWidget {
  const QLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 50.h,
      child: Shimmer.fromColors(
        baseColor: QColors.primary.withOpacity(0.4),
        highlightColor: QColors.primary,
        child: SvgPicture.asset(
          'assets/icons/img-logo.svg',
        ),
      ),
    );
  }
}
