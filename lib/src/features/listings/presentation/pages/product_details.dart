import 'package:cached_network_image/cached_network_image.dart';
import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/core/utils/snackbar.dart';
import 'package:didi/src/core/widgets/custom_button.dart';
import 'package:didi/src/features/listings/cart_bloc/cart_bloc_bloc.dart';
import 'package:didi/src/features/listings/details_bloc/products_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.id});

  final String id;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  get isTablet => null;
  int orderQunatity = 1;

  @override
  void initState() {
    super.initState();
    final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
    context
        .read<DetailsProductsBloc>()
        .add(GetDetailsProductEvent(id: widget.id, token: user.token));
  }

  void increaseQuantity(int stockQuantity) {
    if (orderQunatity < stockQuantity) {
      setState(() {
        orderQunatity += 1;
      });
    }
  }

  void decreaseQuantity() {
    if (orderQunatity > 1) {
      setState(() {
        orderQunatity -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsProductsBloc, DetailsProductsState>(
      builder: (context, state) {
        if (state is DetailsProductsLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is DetailsProductsFailure) {
          return const Scaffold(
            body: Center(
              child: Text("An unexpected error occured"),
            ),
          );
        }

        if (state is GetDetailsProductSuccess) {
          return BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartFailure) {
                showSnackBar(context, state.message);
              }

              if (state is GetCartProductsSuccess) {
                showSnackBar(context, "Product added to cart");
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "Product details",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 35.h,
                        decoration: BoxDecoration(
                          color: AppThemeColors.kContainerColor,
                          borderRadius: BorderRadius.circular(2.h),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: state.product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Chip(
                          label: Text("Best seller"),
                          avatar: Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                          backgroundColor: AppThemeColors.kPrimaryButtonColor,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              state.product.title,
                              style: TextStyle(
                                fontSize: 17.5.sp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            'GHC ${state.product.price}',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              color: AppThemeColors.kPrimaryButtonColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          const Text(
                            "Available in Stock:  ",
                            style: TextStyle(
                                color: AppThemeColors.kPrimaryButtonColor),
                          ),
                          Text(
                            "${state.product.stockQuantity}",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppThemeColors.kPrimaryButtonColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        state.product.description,
                        style: const TextStyle(
                            height: 1.5,
                            color: AppThemeColors.kBasketTextColor,
                            fontFamily: "Poppins"),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                color: AppThemeColors.kBottonNavigationBarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: 2.w),
                          TextButton.icon(
                            onPressed: () => decreaseQuantity(),
                            label: Icon(
                              Icons.remove,
                              size: 22.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            "$orderQunatity",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 2.w),
                          TextButton.icon(
                            onPressed: () =>
                                increaseQuantity(state.product.stockQuantity),
                            label: Icon(
                              Icons.add,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: CustomButton(
                        text: "Add to Cart",
                        onPressed: () => context.read<CartBloc>().add(
                              AddToCartEvent(
                                  product: state.product, qty: orderQunatity),
                            ),
                        verticalPadding: 1.4.h,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
