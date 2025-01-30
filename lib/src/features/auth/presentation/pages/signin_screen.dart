import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/common/widgets/loader.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/utils/snackbar.dart';
import 'package:didi/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:didi/src/core/widgets/auth_input_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:didi/src/core/widgets/custom_button.dart';
import 'package:routemaster/routemaster.dart';
import '../widgets/signup_icons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();

  void _onSubmitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // context.read<AuthBloc>().add(LoginWithEmailPasswordEvent(
      //       email: _emailController.text.trim(),
      //       password: _password1Controller.text.trim(),
      //     ));
      context.read<AppUserCubit>().mockUserLoggenIn();
    } else {
      return;
    }
  }

  @override
  void dispose() {
    _password1Controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                "Welcome to Vendobuyo",
                style: TextStyle(
                  fontSize: 19.7.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 0.8.h),
              Text(
                "Lets log you in to get started",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontFamily: "Poppins"),
                    ),
                    SizedBox(height: 1.h),
                    AuthInputField(
                      controller: _emailController,
                      hintText: "Enter your email",
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
                    SizedBox(height: 3.h),
                    const Text(
                      "Password",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontFamily: "Poppins"),
                    ),
                    SizedBox(height: 1.h),
                    AuthInputField(
                      controller: _password1Controller,
                      hintText: "Enter password",
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
                    SizedBox(height: 0.8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Routemaster.of(context)
                                .push("/signIn/resetPasswordRequest");
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Poppins",
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 4.h),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          showSnackBar(context, state.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Loader();
                        }
                        return CustomButton(
                          text: "Login",
                          width: 90.w,
                          onPressed: () => _onSubmitForm(context),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "Sign in with",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.5.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  const Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignUpIcons(
                    svgUrl: "assets/svg/google_icon.svg",
                    onTap: () {},
                  ),
                  SizedBox(width: 5.w),
                  SignUpIcons(
                    svgUrl: "assets/svg/facebook_icon.svg",
                    onTap: () {},
                  ),
                  SizedBox(width: 5.w),
                  SignUpIcons(
                    svgUrl: "assets/svg/apple_icon.svg",
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 15.8.sp,
                    ),
                    children: [
                      TextSpan(
                        text: "sign up here",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.blue,
                          fontSize: 15.8.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Routemaster.of(context).replace("/signUp");
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
