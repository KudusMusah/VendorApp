import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderLocationCard extends StatelessWidget {
  const OrderLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppThemeColors.kContainerColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: 3.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.timelapse),
                const SizedBox(width: 10),
                Text(
                  "25 - 40 mins",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: AppThemeColors.kWhiteColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            Divider(
              height: 2.h,
              color: AppThemeColors.kDividerColor,
              thickness: 0.5,
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/location.svg",
                      height: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Sunlodge Hotel",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: AppThemeColors.kWhiteColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/svg/go_to.svg",
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              height: isTablet ? 27.h : 20.h,
              decoration: BoxDecoration(
                color: AppThemeColors.kPrimaryBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
