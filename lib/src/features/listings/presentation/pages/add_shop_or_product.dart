import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:routemaster/routemaster.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double cardHeightWidth = 120;
    double iconSize = 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Routemaster.of(context).push("shop"),
              child: Column(
                children: [
                  SizedBox(
                    height: cardHeightWidth,
                    width: cardHeightWidth,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppThemeColors.kContainerColor,
                      child: Center(
                        child: Icon(
                          Icons.shopping_basket,
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
                  const Text("Shop")
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Routemaster.of(context).push("product"),
              child: Column(
                children: [
                  SizedBox(
                    height: cardHeightWidth,
                    width: cardHeightWidth,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppThemeColors.kContainerColor,
                      child: Center(
                        child: Icon(
                          Icons.production_quantity_limits,
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
                  const Text("Products")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
