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

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({
    super.key,
    required this.email,
    required this.resetCode,
  });

  final String email;
  final String resetCode;

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  void _onSubmitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Routemaster.of(context).push("/signIn/passwordResetComplete");
      // context.read<AuthBloc>().add(ChangePasswordEvent(
      //       email: widget.email,
      //       resetCode: widget.resetCode,
      //       password: _password1Controller.text.trim(),
      //     ));
    } else {
      return;
    }
  }

  @override
  void dispose() {
    _password1Controller.dispose();
    _password2Controller.dispose();
    super.dispose();
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
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text(
                  "New Password",
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 0.8.h),
                Text(
                  "Now enter your new password",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 13.3.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 1.h),
                      AuthInputField(
                        controller: _password1Controller,
                        hintText: "Enter new password",
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter password";
                          } else if (value.length < 7) {
                            return "Password should be more than 6 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 3.h),
                      const Text(
                        "Confirm Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontFamily: "Poppins"),
                      ),
                      SizedBox(height: 1.h),
                      AuthInputField(
                        controller: _password2Controller,
                        hintText: "Confirm password",
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm password";
                          } else if (value.length < 7) {
                            return "Password should be more than 6 characters";
                          } else if (value != _password1Controller.text) {
                            return "The 2 password fields do not match";
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

                          if (state is AuthSuccess) {
                            Routemaster.of(context)
                                .push("/signIn/passwordResetComplete");
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Loader();
                          }
                          return CustomButton(
                            text: "Reset password",
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
        ));
  }
}
