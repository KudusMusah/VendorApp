import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/core/widgets/auth_input_field.dart';
import 'package:didi/src/features/orders/presentation/widgets/basket_item.dart';
import 'package:didi/src/features/orders/presentation/widgets/order_location_card.dart';
import 'package:didi/src/features/orders/presentation/widgets/order_total_cntainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final _promoCodeController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _deliveryController.dispose();
    _promoCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;
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
      body: SingleChildScrollView(
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
                  const BasketItem(),
                  SizedBox(height: 2.h),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppThemeColors.kBasketTabBorderColor,
                      ),
                    ),
                    height: 6.h,
                    child: TabBar(
                      dividerHeight: 0,
                      labelPadding: EdgeInsets.zero,
                      labelColor: AppThemeColors.kPrimaryBackgroundColor,
                      unselectedLabelColor: AppThemeColors.kWhiteColor,
                      indicator: BoxDecoration(
                        color: AppThemeColors.kPrimaryButtonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      controller: _tabController,
                      tabs: [
                        Container(
                          decoration: const BoxDecoration(),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Delivery",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5.sp,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Pickup",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
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
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.symmetric(vertical: 2),
                    leading: SvgPicture.asset(
                      "assets/svg/location.svg",
                      height: 20,
                    ),
                    title: Text(
                      "Choose delivery location",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16.sp,
                        color: AppThemeColors.kStartingPriceColor,
                      ),
                    ),
                    trailing: SvgPicture.asset(
                      "assets/svg/go_to.svg",
                    ),
                  ),
                  SizedBox(height: 2.h),
                  AuthInputField(
                    controller: _deliveryController,
                    hintText: "Delivery notes",
                  ),
                  SizedBox(height: 2.5.h),
                  Text(
                    "Promo Code",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15.5.sp,
                      color: AppThemeColors.kBasketTextColor,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  AuthInputField(
                    controller: _promoCodeController,
                    hintText: "Enter promo code",
                  ),
                  SizedBox(height: 2.5.h),
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
            const OrderTotalContainer(),
            SizedBox(height: 2.h),
            const OrderLocationCard(),
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: SlideAction(
                sliderButtonIconSize: isTablet ? 3.3.h : 2.6.h,
                height: 7.5.h,
                onSubmit: () async {},
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
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
