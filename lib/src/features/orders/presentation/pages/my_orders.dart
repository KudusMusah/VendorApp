import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/orders/bloc/order_bloc.dart';
import 'package:didi/src/features/orders/presentation/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
    context.read<OrderBloc>().add(GetUserOrders(token: user.token));

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
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderFailure) {
            return const Center(
              child: Text(
                "An unexpected error occured",
              ),
            );
          }

          if (state is GetUserOrdersSuccess) {
            if (state.orders.isEmpty) {
              return Center(
                child: Text(
                  "No orders placed",
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: AppThemeColors.kStartingPriceColor,
                  ),
                ),
              );
            }
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
              child: ListView.builder(
                reverse: true,
                itemCount: state.orders.length,
                itemBuilder: (context, index) => OrderItem(
                  orderItem: state.orders[index],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
