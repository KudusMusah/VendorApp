import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/theme_colors.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 90.h,
            child: Stack(
              children: [
                Positioned(
                  left: 6.w,
                  bottom: 22.h,
                  child: Image.asset(
                    "assets/images/qr_code.png",
                    width: 88.w,
                  ),
                ),
                Positioned(
                  left: 15.w,
                  bottom: 26.h,
                  child: Container(
                    width: 70.w,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: AppThemeColors.kOnboardingShadowColor,
                          blurRadius: 70,
                          spreadRadius: 0,
                          offset: Offset(0, 0), // Positioning the shadow below
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
