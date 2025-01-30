import 'package:cached_network_image/cached_network_image.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  clipBehavior: Clip.hardEdge,
                  height: isTablet ? 10.h : 9.h,
                  width: isTablet ? 21.w : 25.w,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://plus.unsplash.com/premium_photo-1661769021743-7139c6fc4ab9?q=80&w=3432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 7),
              SizedBox(
                width: 33.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description of product 1",
                      style: TextStyle(
                        fontSize: 14.7.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: AppThemeColors.kWhiteColor,
                      ),
                    ),
                    Text(
                      "GHC 15.00",
                      style: TextStyle(
                        fontSize: 14.7.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: AppThemeColors.kPrimaryButtonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/svg/trash.svg",
              height: 2.5.h,
            ),
          )
        ],
      ),
    );
  }
}
