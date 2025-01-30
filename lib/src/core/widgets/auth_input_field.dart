import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AuthInputField extends StatelessWidget {
  const AuthInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: AppThemeColors.kPrimaryButtonColor,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.all(1.8.h),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppThemeColors.kWhiteColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      validator: validator,
    );
  }
}
