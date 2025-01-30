import 'package:didi/src/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:didi/src/core/widgets/custom_button.dart';
import 'package:routemaster/routemaster.dart';

class PasswordResetComplete extends StatefulWidget {
  const PasswordResetComplete({super.key});

  @override
  State<PasswordResetComplete> createState() => _PasswordResetCompleteState();
}

class _PasswordResetCompleteState extends State<PasswordResetComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/celebration.png",
                width: 70.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "Password changed successfully!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  "Your password has been successfully changed.We will update our system with the new credentials. Thank you!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 13.5.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomButton(
                width: 100.w,
                text: "Back to login",
                onPressed: () {
                  Routemaster.of(context)
                      .popUntil((route) => route.path == '/signIn');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
