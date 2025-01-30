import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:didi/src/core/theme/theme_colors.dart';

class PinField extends StatelessWidget {
  const PinField({super.key, required this.onChanged});

  final void Function(String val) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 12.w,
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          hintText: "0",
          errorStyle: const TextStyle(height: 0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppThemeColors.kPrimaryButtonColor,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.all(1.3.h),
          filled: true,
        ),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty || int.tryParse(value) == null) {
            return "";
          }
          return null;
        },
      ),
    );
  }
}
