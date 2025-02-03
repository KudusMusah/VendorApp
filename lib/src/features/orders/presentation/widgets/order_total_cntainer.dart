import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/listings/models/products.dart';
import 'package:didi/src/features/orders/presentation/widgets/price_info.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderTotalContainer extends StatelessWidget {
  const OrderTotalContainer(
      {super.key, required this.products, required this.quantity});

  final List<Product> products;
  final List<int> quantity;

  double calculateSubTotal() {
    double subtotal = 0;
    for (int i = 0; i < products.length; i++) {
      subtotal += products[i].price * quantity[i];
    }
    return double.parse(subtotal.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = calculateSubTotal();
    final serviceFee = double.parse((0.05 * subtotal).toStringAsFixed(2));
    double deliveryFee = products.length * 15.0;

    if (deliveryFee < 20) {
      deliveryFee = 20;
    }

    final total = subtotal + serviceFee + deliveryFee;

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
            PriceInfo(
              price: "$subtotal",
              title: "Subtotal",
              isBold: true,
            ),
            SizedBox(height: 0.5.h),
            PriceInfo(
              price: "$serviceFee",
              title: "Service fee",
            ),
            SizedBox(height: 0.5.h),
            PriceInfo(
              price: "$deliveryFee",
              title: "Delivery fee",
            ),
            SizedBox(height: 3.h),
            Divider(
              height: 2.h,
              color: AppThemeColors.kDividerColor,
              thickness: 0.5,
            ),
            PriceInfo(
              price: "$total",
              title: "Total",
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}
