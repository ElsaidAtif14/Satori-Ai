import 'package:flutter/material.dart';
import 'package:test_ai/core/utils/text_styles.dart';
import 'package:test_ai/core/widgets/satori_title.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SatoriTitle(),
        Text(
          'INTELLIGENT ZEN',
          style: TextStyles.regular14.copyWith(color: Color(0xff8B909F)),
        ),
      ],
    );
  }
}

