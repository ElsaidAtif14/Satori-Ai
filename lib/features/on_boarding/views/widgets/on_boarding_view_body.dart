import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'custom_glow_ring.dart';
import 'glowing_orb.dart';
import 'on_boarding_footer.dart';
import 'on_boarding_header.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
      child: Column(
        children: [
          OnBoardingHeader(),
          Gap(screenHeight * 0.08),
          CustomGlowRing(
            size: 175,
            child: CustomGlowRing(
              size: 150,
              child: CustomGlowRing(
                size: 125,
                child: GlowingOrb(size: 120),
              ),
            ),
          ),

          Gap(screenHeight * 0.04),
          Expanded(child: OnBoardingFooter()),
        ],
      ),
    );
  }
}
