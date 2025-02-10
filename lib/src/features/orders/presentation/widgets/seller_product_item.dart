import 'package:cached_network_image/cached_network_image.dart';
import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/listings/models/products.dart';
import 'package:didi/src/features/listings/seller_crud_bloc/seller_crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:routemaster/routemaster.dart';

class SellerProductItem extends StatelessWidget {
  const SellerProductItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              SizedBox(
                width: 33.w,
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
                      "Quantity:  ${product.stockQuantity}",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: AppThemeColors.kStartingPriceColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () =>
                    Routemaster.of(context).push('edit_product/${product.id}'),
                icon: const Icon(
                  Icons.edit_note,
                ),
              ),
              IconButton(
                onPressed: () {
                  final user =
                      (context.read<AppUserCubit>().state as AppUserLoggedIn)
                          .user;
                  context.read<SellerCrudBloc>().add(SellerDeleteProducts(
                      productId: product.id, token: user.token));
                },
                icon: SvgPicture.asset(
                  "assets/svg/trash.svg",
                  height: 2.5.h,
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
