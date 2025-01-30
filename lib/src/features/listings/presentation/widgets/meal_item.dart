import 'package:cached_network_image/cached_network_image.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:routemaster/routemaster.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Routemaster.of(context).push("/details/productId"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppThemeColors.kTextFieldColor),
            clipBehavior: Clip.hardEdge,
            width: double.infinity,
            height: Device.screenType == ScreenType.tablet ? 15.h : 12.h,
            child: CachedNetworkImage(
              imageUrl:
                  "https://plus.unsplash.com/premium_photo-1661769021743-7139c6fc4ab9?q=80&w=3432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Text(
                "Product description",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.check_circle,
                size: 15.sp,
                color: AppThemeColors.kPrimaryButtonColor,
              )
            ],
          ),
          const SizedBox(height: 1),
          Row(
            children: [
              Icon(
                Icons.production_quantity_limits,
                size: 13.sp,
                color: AppThemeColors.kPrimaryButtonColor,
              ),
              const SizedBox(width: 5),
              Text(
                "32 units left",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12.3.sp,
                  fontWeight: FontWeight.w500,
                  color: AppThemeColors.kPrimaryButtonColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
