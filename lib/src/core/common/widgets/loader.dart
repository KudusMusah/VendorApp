import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppThemeColors.kPrimaryButtonColor,
        ),
      ),
    );
  }
}
