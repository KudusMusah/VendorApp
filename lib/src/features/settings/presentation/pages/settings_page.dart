import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:routemaster/routemaster.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.horizontalPadding,
            vertical: isTablet ? 5.h : 2.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ubaida Abdul",
                style: TextStyle(
                  color: AppThemeColors.kWhiteColor,
                  fontSize: 17.7.sp,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  Text(
                    "+233246339813",
                    style: TextStyle(
                      color: AppThemeColors.kWhiteColor,
                      fontSize: 15.sp,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(width: 2.5.w),
                  Container(
                    width: 1.w,
                    height: 1.w,
                    decoration: const BoxDecoration(
                      color: AppThemeColors.kWhiteColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Routemaster.of(context).push("/updatePhone"),
                    child: Row(
                      children: [
                        Text(
                          "Edit",
                          style: TextStyle(
                            color: AppThemeColors.kWhiteColor,
                            fontSize: 15.sp,
                            fontFamily: "Poppins",
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/svg/greater_than.svg",
                          height: 2.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 1.5.h),
              ListTile(
                onTap: () {},
                contentPadding:
                    EdgeInsets.symmetric(vertical: isTablet ? 1.h : 0),
                leading: SvgPicture.asset(
                  "assets/svg/payment.svg",
                  height: 2.2.h,
                ),
                title: Text(
                  "Payment",
                  style: TextStyle(
                    color: AppThemeColors.kWhiteColor,
                    fontSize: 15.sp,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding:
                    EdgeInsets.symmetric(vertical: isTablet ? 1.h : 0),
                leading: SvgPicture.asset(
                  "assets/svg/telegram.svg",
                  height: 2.2.h,
                ),
                title: Text(
                  "Promo Codes",
                  style: TextStyle(
                    color: AppThemeColors.kWhiteColor,
                    fontSize: 15.sp,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding:
                    EdgeInsets.symmetric(vertical: isTablet ? 1.h : 0),
                leading: SvgPicture.asset(
                  "assets/svg/profile.svg",
                  height: 2.2.h,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: AppThemeColors.kWhiteColor,
                    fontSize: 15.sp,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding:
                    EdgeInsets.symmetric(vertical: isTablet ? 1.h : 0),
                leading: SvgPicture.asset(
                  "assets/svg/settings.svg",
                  height: 2.2.h,
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: AppThemeColors.kWhiteColor,
                    fontSize: 15.sp,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding:
                    EdgeInsets.symmetric(vertical: isTablet ? 1.h : 0),
                leading: SvgPicture.asset(
                  "assets/svg/about.svg",
                  height: 2.2.h,
                ),
                title: Text(
                  "About",
                  style: TextStyle(
                    color: AppThemeColors.kWhiteColor,
                    fontSize: 15.sp,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
