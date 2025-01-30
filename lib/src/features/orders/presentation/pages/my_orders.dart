import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/enums/status.dart';
import 'package:didi/src/features/orders/presentation/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: Constants.horizontalPadding,
        title: Text(
          "My Orders",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => OrderItem(
            status: index % 3 == 0
                ? OrderStatus.delivered
                : index % 3 == 1
                    ? OrderStatus.pending
                    : OrderStatus.cancelled,
            showTrailing: index == 0,
          ),
        ),
      ),
    );
  }
}
