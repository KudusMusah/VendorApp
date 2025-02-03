import 'package:cached_network_image/cached_network_image.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/listings/models/products.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:routemaster/routemaster.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Routemaster.of(context).push("/details/${product.id}"),
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
              imageUrl: product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              SizedBox(
                width: 35.w,
                child: Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
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
                "${product.stockQuantity} units left",
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
