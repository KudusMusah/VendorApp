import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/core/widgets/auth_input_field.dart';
import 'package:didi/src/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;

    final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;

    final _usernameController = TextEditingController(text: user.name);
    final _emailController = TextEditingController(text: user.email);
    final _phoneController = TextEditingController(text: user.phone);

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
                ],
              ),
              SizedBox(height: 3.h),
              Text(
                "Username",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15.5.sp,
                  color: AppThemeColors.kBasketTextColor,
                ),
              ),
              SizedBox(height: 1.h),
              AuthInputField(
                controller: _usernameController,
                hintText: user.name,
              ),
              SizedBox(height: 2.5.h),
              Text(
                "email",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15.5.sp,
                  color: AppThemeColors.kBasketTextColor,
                ),
              ),
              SizedBox(height: 1.h),
              AuthInputField(
                controller: _emailController,
                hintText: user.email,
              ),
              SizedBox(height: 2.5.h),
              Text(
                "Phone Number",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15.5.sp,
                  color: AppThemeColors.kBasketTextColor,
                ),
              ),
              SizedBox(height: 1.h),
              AuthInputField(
                controller: _phoneController,
                hintText: user.phone,
              ),
              SizedBox(height: 3.h),
              CustomButton(
                text: "Update",
                width: 90.w,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
