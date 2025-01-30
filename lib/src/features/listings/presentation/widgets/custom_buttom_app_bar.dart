import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButtomAppBar extends StatefulWidget {
  const CustomButtomAppBar({super.key});

  @override
  State<CustomButtomAppBar> createState() => _CustomButtomAppBarState();
}

class _CustomButtomAppBarState extends State<CustomButtomAppBar> {
  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity += 1;
    });
  }

  void decreaseQuantity() {
    setState(() {
      quantity -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;

    return BottomAppBar(
      height: 7.5.h,
      color: AppThemeColors.kBottonNavigationBarColor,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => decreaseQuantity(),
                    icon: Icon(
                      Icons.remove,
                      size: 21.sp,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    "$quantity",
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  IconButton(
                    onPressed: () => increaseQuantity(),
                    icon: Icon(
                      Icons.add,
                      size: 21.sp,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: isTablet
                        ? const EdgeInsets.symmetric(
                            horizontal: 65, vertical: 10)
                        : const EdgeInsets.symmetric(horizontal: 40),
                    backgroundColor: AppThemeColors.kPrimaryButtonColor,
                  ),
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: AppThemeColors.kWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
