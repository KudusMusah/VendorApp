import 'package:didi/src/core/common/widgets/loader.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/utils/snackbar.dart';
import 'package:didi/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:didi/src/core/widgets/auth_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/core/widgets/custom_button.dart';
import 'package:routemaster/routemaster.dart';

class ResetPasswordRequest extends StatefulWidget {
  const ResetPasswordRequest({super.key});

  @override
  State<ResetPasswordRequest> createState() => _ResetPasswordRequestState();
}

class _ResetPasswordRequestState extends State<ResetPasswordRequest> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _onSubmitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // _formKey.currentState!.save();
      // context.read<AuthBloc>().add(ForgotPasswordEvent(
      //       email: _emailController.text.trim(),
      //     ));
      Routemaster.of(context).push(
          "/signIn/resetPasswordRequest/otpVerification/${_emailController.text.trim()}");
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 0.8.h),
            Text(
              "Enter the email associated with your  account and we’ll send you an email with an  instruction to reset your account",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 13.3.sp,
              ),
            ),
            SizedBox(height: 4.5.h),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email Address",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontFamily: "Poppins"),
                  ),
                  SizedBox(height: 1.h),
                  AuthInputField(
                    controller: _emailController,
                    hintText: "Enter your email address",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter an email address";
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2.3.h),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        showSnackBar(context, state.message);
                      }

                      if (state is AuthSuccessVoid) {
                        Routemaster.of(context).push(
                            "/signIn/resetPasswordRequest/otpVerification/${_emailController.text.trim()}");
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Loader();
                      }
                      return CustomButton(
                        text: "Continue",
                        width: 90.w,
                        onPressed: () => _onSubmitForm(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
