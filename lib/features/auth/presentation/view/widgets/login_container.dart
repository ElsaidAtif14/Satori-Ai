import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:test_ai/core/helper/extension.dart';
import 'package:test_ai/core/routing/routes.dart';
import 'package:test_ai/core/utils/text_styles.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/dont_have_account_text.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/login_devider.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/login_form.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/sign_with_google_button.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: const Color(0xff1C1B1C),
      ),
      child: Column(
        children: [
          Text(
            'welcome back',
            style: TextStyles.semiBold28.copyWith(color: Color(0xffE5E2E3)),
          ),
          Text(
            'Enter your credentials to access your\nworkspace.',
            textAlign: TextAlign.center,
            style: TextStyles.regular14.copyWith(color: Color(0xff8B909F)),
          ),
          Gap(32),
          LoginForm(),
          LoginDevider(),
          SignWithGoogleButton(),
          Gap(32),
          DontHaveAccountText(
            onTap: () {
              context.pushReplacementNamed(Routes.signupView);
            },
          ),
        ],
      ),
    );
  }
}
