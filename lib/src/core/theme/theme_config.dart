import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ThemeConfig {
  ThemeConfig();

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: AppThemeColors.kPrimaryButtonColor,
      scaffoldBackgroundColor: AppThemeColors.kPrimaryBackgroundColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppThemeColors.kPrimaryBackgroundColor,
          surfaceTintColor: AppThemeColors.kPrimaryBackgroundColor),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: const TextStyle(color: AppThemeColors.kPrimaryButtonColor),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppThemeColors.kPrimaryButtonColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppThemeColors.kPrimaryButtonColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppThemeColors.kPrimaryButtonColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        labelStyle: const TextStyle(
          color: AppThemeColors.kWhiteColor,
        ),
      ),
      buttonTheme: const ButtonThemeData().copyWith(
        buttonColor: AppThemeColors.kPrimaryButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppThemeColors.kTextFieldColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        labelStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppThemeColors.kWhiteColor,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppThemeColors.kBottonNavigationBarColor,
        selectedItemColor: AppThemeColors.kPrimaryButtonColor,
        selectedLabelStyle: TextStyle(
          color: AppThemeColors.kPrimaryButtonColor,
          fontSize: 13.3.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13.3.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  ThemeData get lightTheme {
    return ThemeData.light();
  }
}
