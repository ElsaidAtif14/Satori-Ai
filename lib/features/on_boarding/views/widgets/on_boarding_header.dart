import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:test_ai/core/constants/constant.dart';
import 'package:test_ai/core/helper/extension.dart';
import 'package:test_ai/core/helper/shared_pref_helper.dart';
import 'package:test_ai/core/routing/routes.dart';
import 'package:test_ai/core/utils/text_styles.dart';
import 'package:test_ai/core/widgets/blue_dot.dart';

class OnBoardingHeader extends StatelessWidget {
  const OnBoardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlueDot(),
        Gap(6),
        Text('Satori Ai', style: TextStyles.semiBold28),
        Spacer(),
        GestureDetector(
          onTap: () {
            context.pushNamedAndRemoveUntil(
              Routes.loginView,
              predicate: (route) => false,
            );
            SharedPrefHelper.setData(onBoardingViewSeenKey, true);
          },
          child: Text('Skip ', style: TextStyles.regular14),
        ),
      ],
    );
  }
}
