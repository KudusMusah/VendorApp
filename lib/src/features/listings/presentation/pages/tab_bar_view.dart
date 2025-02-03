import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/listings/presentation/pages/homepage.dart';
import 'package:didi/src/features/listings/presentation/pages/search_page.dart';
import 'package:didi/src/features/orders/presentation/pages/my_orders.dart';
import 'package:didi/src/features/orders/presentation/pages/my_cart.dart';
import 'package:didi/src/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  void _onTextFieldTap() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  void _onTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      Homepage(onTextFieldTap: _onTextFieldTap),
      const SearchPage(),
      const PaymentScreen(),
      const MyOrders(),
      const SettingsPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 7),
                child: SvgPicture.asset(
                  'assets/svg/home.svg',
                  width: 17.sp,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 0
                        ? AppThemeColors.kPrimaryButtonColor
                        : AppThemeColors.kWhiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 7),
                child: SvgPicture.asset(
                  'assets/svg/search.svg',
                  width: 17.sp,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 1
                        ? AppThemeColors.kPrimaryButtonColor
                        : AppThemeColors.kWhiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 7),
                child: SvgPicture.asset(
                  'assets/svg/basket.svg',
                  width: 17.sp,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 2
                        ? AppThemeColors.kPrimaryButtonColor
                        : AppThemeColors.kWhiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 7),
                child: SvgPicture.asset(
                  'assets/svg/list_ordered.svg',
                  width: 17.sp,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 3
                        ? AppThemeColors.kPrimaryButtonColor
                        : AppThemeColors.kWhiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "My Orders",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 7),
                child: SvgPicture.asset(
                  'assets/svg/settings.svg',
                  width: 17.sp,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 4
                        ? AppThemeColors.kPrimaryButtonColor
                        : AppThemeColors.kWhiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
