import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:test_ai/core/helper/satori_feature.dart'; // تأكد أن satoriFeaturesList معرفة هنا

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({
    super.key,
    required this.carouselSliderController,
    required this.onPageChanged,
  });

  final CarouselSliderController carouselSliderController;
  final Function(int index, CarouselPageChangedReason reason) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(

      carouselController: carouselSliderController,
      itemCount: satoriFeaturesList.length,
      options: CarouselOptions(
        scrollPhysics: NeverScrollableScrollPhysics(),
        viewportFraction: 1,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        onPageChanged: onPageChanged
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final item = satoriFeaturesList[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(16),
            Text(
              item.description,
              style: const TextStyle(fontSize: 14, height: 1.4),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
