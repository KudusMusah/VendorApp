import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/listings/presentation/widgets/home_text_field.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSearchAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomSearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
          vertical: 1.5.h,
        ),
        child: const HomeTextField(
          fillColor: AppThemeColors.kSearchFieldColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(10.h);
}
