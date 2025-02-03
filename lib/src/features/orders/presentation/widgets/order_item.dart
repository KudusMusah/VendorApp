import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/orders/models/order.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.orderItem,
  });

  final MyOrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 0.5.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppThemeColors.kContainerColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: 2.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date: ${orderItem.created}",
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
            Text("Order #${orderItem.id}"),
            SizedBox(height: 0.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (orderItem.status == "delivered")
                  Text(
                    "Delivered!",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppThemeColors.kDeliveredColor,
                    ),
                  ),
                if (orderItem.status == "pending")
                  Text(
                    "Pending!",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppThemeColors.kPendingColor,
                    ),
                  ),
                if (orderItem.status == "cancelled")
                  Text(
                    "Cancelled!",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppThemeColors.kPrimaryButtonColor,
                    ),
                  ),
                const Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 8),
                    child: Text("View Details"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
