import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_ai/constants/assets.dart';
import 'package:test_ai/core/widgets/custom_action_button.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_event.dart';

class SignWithGoogleButton extends StatelessWidget {
  const SignWithGoogleButton({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomActionButton(
      backgroundColor: Colors.white.withOpacity(0.1),
      text: 'Sign in with Google',
      onPressed: () {
        context.read<AuthBloc>().add(LoginWithGoogleEvent());
      },
      leadingIcon: SvgPicture.asset(Assets.assetsImagesIconsGoogleIcon),
    );
  }
}
