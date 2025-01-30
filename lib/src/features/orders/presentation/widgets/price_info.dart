import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PriceInfo extends StatelessWidget {
  const PriceInfo(
      {super.key, required this.title, required this.price, this.isBold});

  final String title;
  final String price;
  final bool? isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isBold == true
              ? TextStyle(
                  fontSize: 16.5.sp,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                )
              : TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Poppins",
                  color: AppThemeColors.kBasketTextColor,
                ),
        ),
        Text(
          "GHC $price",
          style: isBold == true
              ? TextStyle(
                  fontSize: 16.5.sp,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                )
              : TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Poppins",
                  color: AppThemeColors.kBasketTextColor,
                ),
        ),
      ],
    );
  }
}
