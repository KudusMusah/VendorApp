import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RowTile extends StatelessWidget {
  const RowTile({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
  });

  final String title;
  final String value;
  final String groupValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                visualDensity: VisualDensity
                    .compact, // Use VisualDensity.standard for default
              ),
              child: Radio(
                value: value,
                groupValue: groupValue,
                onChanged: (val) {},
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: AppThemeColors.kWhiteColor,
                fontSize: 15.5.sp,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
        Text(
          "GHC 5.00",
          style: TextStyle(
            color: AppThemeColors.kWhiteColor,
            fontSize: 15.5.sp,
            fontFamily: "Poppins",
          ),
        ),
      ],
    );
  }
}
