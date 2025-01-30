import 'package:cached_network_image/cached_network_image.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://media.istockphoto.com/id/862201618/photo/if-you-want-to-say-something-say-it-here.webp?s=2048x2048&w=is&k=20&c=QOGnoPGR_8Ey-kjhMCzSa039B9xxU3RtF8I26FQvOj0=",
            fit: BoxFit.cover,
            height: Device.screenType == ScreenType.tablet ? 16.h : 14.h,
            width: double.infinity,
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get 50% off all local products",
                    style: TextStyle(
                      // fontFamily: "Poppins",
                      fontWeight: FontWeight.w800,
                      color: AppThemeColors.kWhiteColor,
                      fontSize: 15.3.sp,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.7),
                      color: AppThemeColors.kPrimaryButtonColor,
                    ),
                    child: Text(
                      "Order now",
                      style: TextStyle(
                        color: AppThemeColors.kWhiteColor,
                        fontFamily: "Poppins",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
