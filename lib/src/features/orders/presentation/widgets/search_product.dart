import 'package:cached_network_image/cached_network_image.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/listings/models/products.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:routemaster/routemaster.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;
    return GestureDetector(
      onTap: () => Routemaster.of(context).push("/details/${product.id}"),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                ),
                clipBehavior: Clip.hardEdge,
                height: isTablet ? 10.h : 9.h,
                width: isTablet ? 21.w : 25.w,
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.7.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: AppThemeColors.kWhiteColor,
                      ),
                    ),
                    Text(
                      "GHC ${product.price}",
                      style: TextStyle(
                        fontSize: 14.7.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: AppThemeColors.kPrimaryButtonColor,
                      ),
                    ),
                    Text(
                      "${product.stockQuantity} units left",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: AppThemeColors.kPrimaryButtonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
