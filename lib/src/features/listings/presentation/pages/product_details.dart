import 'package:cached_network_image/cached_network_image.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productId});

  final String productId;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  get isTablet => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  imageUrl:
                      "https://plus.unsplash.com/premium_photo-1661769021743-7139c6fc4ab9?q=80&w=3432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
                  Text(
                    "Product Name Here",
                    style: TextStyle(
                      fontSize: 17.5.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "GHC 85.00",
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
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 2.h,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "4.5",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 6.w),
                  Container(
                    width: 1,
                    height: 2.h,
                    color: Colors.white,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "32 units left",
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
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eleifend, urna eu viverra tincidunt, mi nisl aliquet tortor, ac feugiat eros enim vel nulla. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer id orci vel lectus hendrerit vehicula a nec sapien. Quisque bibendum nulla ut sapien dignissim, nec posuere eros dictum.",
                style: TextStyle(
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
              child: CustomButton(
                text: "Add to Cart",
                onPressed: () {},
                verticalPadding: 1.4.h,
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: CustomButton(
                text: "Buy Now",
                onPressed: () {},
                verticalPadding: 1.4.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
