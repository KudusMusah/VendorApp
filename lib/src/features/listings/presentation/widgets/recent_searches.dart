import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecentSearch extends StatelessWidget {
  const RecentSearch({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/svg/clock.svg",
              height: 2.4.h,
            ),
            SizedBox(width: 3.w),
            Text(
              text,
              style: TextStyle(
                color: AppThemeColors.kWhiteColor,
                fontFamily: "Poppins",
                fontSize: 14.8.sp,
              ),
            )
          ],
        ),
        SizedBox(height: 1.h),
        const Divider(),
      ],
    );
  }
}
