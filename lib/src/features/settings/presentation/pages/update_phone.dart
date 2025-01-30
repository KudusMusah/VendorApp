import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/widgets/custom_button.dart';
import 'package:didi/src/features/settings/presentation/widgets/phone_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:routemaster/routemaster.dart';

class UpdatePhone extends StatefulWidget {
  const UpdatePhone({super.key});

  @override
  State<UpdatePhone> createState() => _UpdatePhoneState();
}

class _UpdatePhoneState extends State<UpdatePhone> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneController;
  String prefix = "+233";

  void _onSubmitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;
    final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
    _phoneController = TextEditingController(text: user.phone);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Routemaster.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppThemeColors.kWhiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.5.h),
              Text(
                "Update phone number",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                  color: AppThemeColors.kWhiteColor,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                "We’ll send you an sms for verification",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppThemeColors.kWhiteColor,
                ),
              ),
              SizedBox(height: 2.h),
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: isTablet ? 1.h : 0,
                        ),
                        decoration: BoxDecoration(
                          color: AppThemeColors.kDropDownColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: AppThemeColors.kDropDownColor,
                            style: TextStyle(
                              color: AppThemeColors.kWhiteColor,
                              fontFamily: "Poppins",
                              fontSize: 14.5.sp,
                            ),
                            padding: EdgeInsets.zero,
                            isExpanded: true,
                            icon: SvgPicture.asset(
                              "assets/svg/drop_down.svg",
                              height: 2.h,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            onChanged: (val) {
                              if (val == null) {
                                return;
                              }
                              setState(() {
                                prefix = val;
                              });
                            },
                            value: prefix,
                            items: const [
                              DropdownMenuItem(
                                value: "+233",
                                child: Text("+233"),
                              ),
                              DropdownMenuItem(
                                value: "+114",
                                child: Text("+114"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      flex: 8,
                      child: PhoneInputField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().length != 9) {
                            return "$prefix$value is not valid";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              CustomButton(
                text: "Continue",
                width: 90.w,
                onPressed: () => _onSubmitForm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
