
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:test_ai/core/constants/constant.dart';
import 'package:test_ai/core/helper/extension.dart';
import 'package:test_ai/core/helper/satori_feature.dart';
import 'package:test_ai/core/helper/shared_pref_helper.dart';
import 'package:test_ai/core/routing/routes.dart';
import 'package:test_ai/core/utils/app_colors.dart';
import 'package:test_ai/core/widgets/custom_action_button.dart';
import 'package:test_ai/features/on_boarding/views/widgets/custom_cursol_slider.dart';

class OnBoardingFooter extends StatefulWidget {
  const OnBoardingFooter({super.key});

  @override
  State<OnBoardingFooter> createState() => _OnBoardingFooterState();
}

class _OnBoardingFooterState extends State<OnBoardingFooter> {
  late final CarouselSliderController carouselController ;
  double _currentIndex = 0;
@override
  void initState() {
carouselController =
      CarouselSliderController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
      children: [
        CustomCarouselSlider(
          carouselSliderController: carouselController,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index.toDouble();
            });
          },
        ),
        Spacer(),
        DotsIndicator(
          onTap: (position) {
            carouselController.animateToPage(position.toInt());
          },
          dotsCount: satoriFeaturesList.length,
          position: _currentIndex,
          decorator: DotsDecorator(
            size: const Size.square(8.0),
            activeSize: const Size(22.0, 6.0),
            activeColor: AppColors.primary,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        const Gap(30),
        CustomActionButton(
          text: _currentIndex == satoriFeaturesList.length - 1
              ? 'Get Started'
              : 'Next',
          backgroundColor: AppColors.primary,
          width: MediaQuery.of(context).size.width * 0.85,
          textColor: Colors.black,
          onPressed: () {
            if (_currentIndex == satoriFeaturesList.length - 1) {
              context.pushNamedAndRemoveUntil(
                Routes.loginView,
                predicate: (route) =>
                    false, 
              );
              SharedPrefHelper.setData(onBoardingViewSeenKey, true);
            } else {
              carouselController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        const Gap(18),
      ],
    );
    
  }
  

}
