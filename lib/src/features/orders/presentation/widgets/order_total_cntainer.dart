import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/orders/presentation/widgets/price_info.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderTotalContainer extends StatelessWidget {
  const OrderTotalContainer({super.key});

  @override
  Widget build(BuildContext context) {
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
            const PriceInfo(
              price: "99",
              title: "Subtotal",
              isBold: true,
            ),
            SizedBox(height: 0.5.h),
            const PriceInfo(
              price: "0.77",
              title: "Service fee",
            ),
            SizedBox(height: 0.5.h),
            const PriceInfo(
              price: "0.00",
              title: "Tips",
            ),
            SizedBox(height: 0.5.h),
            const PriceInfo(
              price: "5.00",
              title: "Delivery fee",
            ),
            SizedBox(height: 3.h),
            Divider(
              height: 2.h,
              color: AppThemeColors.kDividerColor,
              thickness: 0.5,
            ),
            const PriceInfo(
              price: "104.77",
              title: "Total",
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}
