import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/onboarding/presentation/widgets/page_indicator.dart';
import 'package:flutter/material.dart';

import 'package:didi/src/features/onboarding/presentation/pages/onboarding_screen1.dart';
import 'package:didi/src/features/onboarding/presentation/pages/onboarding_screen2.dart';
import 'package:didi/src/features/onboarding/presentation/pages/onboarding_screen3.dart';
import 'package:didi/src/features/onboarding/presentation/pages/onboarding_screen4.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            controller: _pageController,
            children: const <Widget>[
              OnboardingScreen1(),
              OnboardingScreen2(),
              OnboardingScreen3(),
              OnboardingScreen4(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.93),
            child: SizedBox(
              height: 10.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    width: _currentPage == 0
                        ? 13.w
                        : _currentPage == 3
                            ? 0
                            : 5.w,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 300),
                    child: const PageIndicator(
                      color: AppThemeColors.kPageIndicatorColor,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  AnimatedContainer(
                    width: _currentPage == 1
                        ? 13.w
                        : _currentPage == 3
                            ? 0
                            : 5.w,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 300),
                    child: const PageIndicator(
                      color: AppThemeColors.kPageIndicatorColor,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  AnimatedContainer(
                    width: _currentPage == 2
                        ? 13.w
                        : _currentPage == 3
                            ? 0
                            : 5.w,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 300),
                    child: const PageIndicator(
                      color: AppThemeColors.kPageIndicatorColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
