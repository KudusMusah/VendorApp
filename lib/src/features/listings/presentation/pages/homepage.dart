import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:didi/src/features/listings/bloc/products_bloc_bloc.dart';
import 'package:didi/src/features/listings/presentation/widgets/announcement_card.dart';
import 'package:didi/src/features/listings/presentation/widgets/home_text_field.dart';
import 'package:didi/src/features/listings/presentation/widgets/meal_item.dart';
import 'package:didi/src/features/listings/shops_bloc/shops_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:routemaster/routemaster.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.onTextFieldTap});

  final VoidCallback onTextFieldTap;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedShop = "";

  @override
  void initState() {
    super.initState();
    final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
    context.read<ProductsBloc>().add(GetAllProductsEvent(token: user.token));
    context.read<ShopsBloc>().add(GetAllShops(token: user.token));
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;
    final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 1.7.h),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60.w,
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: "Hi There ",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                            children: [
                              TextSpan(
                                text: user.name,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: AppThemeColors.kWhiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.5.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "How is your day going?",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12.5.sp,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      if (user.role == "seller")
                        GestureDetector(
                          onTap: () =>
                              Routemaster.of(context).push("/seller_dahboard"),
                          child: Icon(
                            Icons.dashboard_customize_outlined,
                            size: 20.sp,
                            color: AppThemeColors.kBasketTabBorderColor,
                          ),
                        ),
                      SizedBox(width: 3.w),
                      GestureDetector(
                        onTap: () =>
                            context.read<AuthBloc>().add(LogoutUserEvent()),
                        child: Icon(
                          Icons.logout,
                          size: 20.sp,
                          color: AppThemeColors.kBasketTabBorderColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.7.w),
              child: HomeTextField(
                reaOnly: true,
                onTap: widget.onTextFieldTap,
              ),
            ),
            SizedBox(height: 2.3.h),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
              child: const AnnouncementCard(),
            ),
            SizedBox(height: 2.3.h),
            BlocBuilder<ShopsBloc, ShopsState>(
              builder: (context, state) {
                if (state is ShopsLoading) {
                  return Center(
                    child: SizedBox(
                      height: 1.5.h,
                      width: 1.5.h,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is ShopsSuccess) {
                  return SizedBox(
                    height: 4.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.shops.length,
                      itemBuilder: (context, index) {
                        final item = state.shops[index];
                        return Padding(
                          padding: EdgeInsets.only(left: isTablet ? 20 : 13),
                          child: GestureDetector(
                            onTap: () {
                              if (item.name == selectedShop) {
                                context.read<ProductsBloc>().add(
                                    GetAllProductsEvent(token: user.token));
                                setState(() {
                                  selectedShop = "";
                                });
                                return;
                              }
                              context.read<ProductsBloc>().add(
                                    GetAllProductsEvent(
                                        token: user.token, shopId: item.id),
                                  );
                              setState(() {
                                selectedShop = item.name;
                              });
                            },
                            child: Chip(
                              padding: EdgeInsets.all(isTablet ? 10 : 8),
                              label: Text(item.name),
                              backgroundColor: item.name == selectedShop
                                  ? AppThemeColors.kPrimaryButtonColor
                                  : AppThemeColors.kTextFieldColor,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
            SizedBox(height: 2.5.h),
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ProductsFailure) {
                  return SizedBox(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }

                if (state is GetAllProductsSuccess) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constants.horizontalPadding),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: isTablet ? 30 : 18,
                        childAspectRatio: 1.18,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return MealItem(
                          product: state.products[index],
                        );
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
