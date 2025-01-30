import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeTextField extends StatelessWidget {
  const HomeTextField({
    super.key,
    this.onTap,
    this.reaOnly = false,
    this.fillColor,
  });

  final VoidCallback? onTap;
  final bool reaOnly;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;
    return TextField(
      readOnly: reaOnly,
      onTap: onTap,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 14.1.sp,
        color: AppThemeColors.kWhiteColor.withOpacity(0.8),
      ),
      decoration: InputDecoration(
        hintText: "What are you looking for?",
        suffixIcon: SvgPicture.asset(
          colorFilter: ColorFilter.mode(
            AppThemeColors.kWhiteColor.withOpacity(0.8),
            BlendMode.srcIn,
          ),
          "assets/svg/search.svg",
          fit: BoxFit.scaleDown,
        ),
        filled: true,
        fillColor: fillColor ?? AppThemeColors.kTextFieldColor,
        contentPadding: isTablet
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
            : const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
    );
  }
}
