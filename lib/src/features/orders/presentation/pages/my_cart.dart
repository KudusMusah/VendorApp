import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/core/utils/snackbar.dart';
import 'package:didi/src/core/widgets/auth_input_field.dart';
import 'package:didi/src/features/listings/cart_bloc/cart_bloc_bloc.dart';
import 'package:didi/src/features/listings/delete_cart_bloc/delete_cart_bloc_bloc.dart';
import 'package:didi/src/features/listings/models/products.dart';
import 'package:didi/src/features/orders/bloc/order_bloc.dart';
import 'package:didi/src/features/orders/presentation/widgets/basket_item.dart';
import 'package:didi/src/features/orders/presentation/widgets/order_location_card.dart';
import 'package:didi/src/features/orders/presentation/widgets/order_total_cntainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:slide_to_act/slide_to_act.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _deliveryController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _deliveryController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void onDeleteProductFromCart(Product product) {
    context.read<DeleteCartBloc>().add(RemoveFromCart(product: product));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;
    final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
    context.read<CartBloc>().add(GetCartProductsEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartFailure) {
            if (state is CartLoading) {
              return const Center(
                child: Text("An unexpected error occured"),
              );
            }
          }

          if (state is GetCartProductsSuccess) {
            if (state.products.isEmpty) {
              return Center(
                child: Text(
                  "No items in Cart",
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: AppThemeColors.kStartingPriceColor,
                  ),
                ),
              );
            }

            return BlocListener<DeleteCartBloc, DeleteCartState>(
              listener: (context, state) {
                if (state is DeleteCartSuccess) {
                  showSnackBar(context, "Item has been removed from Cart");
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.horizontalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              children: state.products.map(
                            (product) {
                              int index = state.products.indexOf(product);
                              return BasketItem(
                                product: product,
                                qty: state.qtys[index],
                                onTap: () => onDeleteProductFromCart(product),
                              );
                            },
                          ).toList()),
                          SizedBox(height: 2.h),
                          Text(
                            "Delivery Details",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16.sp,
                              color: AppThemeColors.kWhiteColor,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          AuthInputField(
                            controller: _deliveryController,
                            hintText: "Enter delivery location",
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Active Contact Number",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15.5.sp,
                              color: AppThemeColors.kBasketTextColor,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          AuthInputField(
                            controller: _phoneController,
                            hintText: "+233 56 345 5678",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h),
                    OrderTotalContainer(
                      products: state.products,
                      quantity: state.qtys,
                    ),
                    SizedBox(height: 2.h),
                    const OrderLocationCard(),
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: BlocListener<OrderBloc, OrderState>(
                        listener: (context, state) {
                          if (state is OrderFailure) {
                            showSnackBar(
                                context, "An unexpected error occured");
                          }

                          if (state is OrderSuccess) {
                            setState(() {});
                            showSnackBar(
                                context, "Order has been placed. Cart cleared");
                          }
                        },
                        child: SlideAction(
                          sliderButtonIconSize: isTablet ? 3.3.h : 2.6.h,
                          height: 7.5.h,
                          onSubmit: () async {
                            double subtotal = 0;
                            for (int i = 0; i < state.products.length; i++) {
                              subtotal +=
                                  state.products[i].price * state.qtys[i];
                            }
                            final serviceFee = double.parse(
                                (0.05 * subtotal).toStringAsFixed(2));
                            double deliveryFee = state.products.length * 15.0;

                            if (deliveryFee < 20) {
                              deliveryFee = 20;
                            }

                            final total = subtotal + serviceFee + deliveryFee;
                            context.read<OrderBloc>().add(
                                  CreateOrder(
                                      products: state.products,
                                      qtys: state.qtys,
                                      token: user.token,
                                      totalPrice: double.parse(
                                        total.toStringAsFixed(2),
                                      )),
                                );
                          },
                          elevation: 0,
                          outerColor: AppThemeColors.kPrimaryButtonColor,
                          innerColor: AppThemeColors.kWhiteColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Place Order",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppThemeColors.kWhiteColor,
                                ),
                              ),
                              Text(
                                "Slide to confirm",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeColors.kWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                  ],
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
