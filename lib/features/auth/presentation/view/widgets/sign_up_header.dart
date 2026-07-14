import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:test_ai/core/utils/text_styles.dart';
import 'package:test_ai/core/widgets/blue_dot.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SATORI AI', style: TextStyles.bold48),
            Gap(8),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: BlueDot(radius: 6),
            ),
          ],
        ),
        Gap(16),
        Text('Welcome to SATORI', style: TextStyles.semiBold28),
        Gap(8),
        Text(
          'Experience the next evolution of intelligent design.',
          style: TextStyles.regular14.copyWith(color: Color(0xffC1C6D6)),
        ),
        
      ],
    );
  }
}
