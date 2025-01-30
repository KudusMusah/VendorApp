import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomChip extends StatefulWidget {
  const CustomChip({super.key, required this.onTap, required this.label});

  final VoidCallback onTap;
  final String label;

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  final isTablet = Device.screenType == ScreenType.tablet;
  int ctr = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        ctr += 1;
        setState(() {});
      },
      child: Chip(
        padding: EdgeInsets.all(isTablet ? 10 : 8),
        label: Text(widget.label),
        backgroundColor: ctr % 2 == 1
            ? AppThemeColors.kPrimaryButtonColor
            : AppThemeColors.kTextFieldColor,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
