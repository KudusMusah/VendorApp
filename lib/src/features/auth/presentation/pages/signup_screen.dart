import 'package:didi/src/core/common/widgets/loader.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/utils/snackbar.dart';
import 'package:didi/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:didi/src/core/widgets/auth_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:didi/src/core/widgets/custom_button.dart';
import 'package:routemaster/routemaster.dart';
import '../widgets/signup_icons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  void _onSubmitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            RegisterWithEmailPasswordEvent(
              email: _emailController.text.trim(),
              password: _password1Controller.text.trim(),
              name: _nameController.text.trim(),
              phone: _phoneController.text.trim(),
            ),
          );
    } else {
      return;
    }
  }

  @override
  void dispose() {
    _password1Controller.dispose();
    _password2Controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.5.h),
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
                    "Lets sign you up to get started",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 3.5.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
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
                        SizedBox(height: 1.h),
                        const Text(
                          "Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(height: 1.h),
                        AuthInputField(
                          controller: _nameController,
                          hintText: "Enter your name",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().length < 4) {
                              return "Name should be at least 4 letters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 1.h),
                        const Text(
                          "Phone",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(height: 1.h),
                        AuthInputField(
                          controller: _phoneController,
                          hintText: "Enter your phone number",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().length < 10) {
                              return "Name should be at least 10 letters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 1.h),
                        const Text(
                          "Password",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(height: 1.h),
                        AuthInputField(
                          obscureText: true,
                          controller: _password1Controller,
                          hintText: "Create a password",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            } else if (value.length < 7) {
                              return "Password should be more than 6 characters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        const Text(
                          "Confirm Password",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(height: 1.h),
                        AuthInputField(
                          obscureText: true,
                          controller: _password2Controller,
                          hintText: "Confirm your password",
                          keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 4.h),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthFailure) {
                              showSnackBar(context, state.message);
                            }

                            if (state is AuthSuccess) {
                              showSnackBar(context,
                                  "Registration successful. Login to get started");
                              Routemaster.of(context).replace("/signIn");
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Loader();
                            }
                            return CustomButton(
                              text: "Sign Up",
                              width: 90.w,
                              onPressed: () => _onSubmitForm(context),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
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
                  SizedBox(height: 5.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 15.8.sp,
                        ),
                        children: [
                          TextSpan(
                            text: "sign in here",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.blue,
                              fontSize: 15.8.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Routemaster.of(context).replace("/signIn");
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
        ),
      ),
    );
  }
}
