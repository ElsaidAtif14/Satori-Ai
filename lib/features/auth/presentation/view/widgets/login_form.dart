import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:test_ai/constants/assets.dart';
import 'package:test_ai/core/utils/app_colors.dart';
import 'package:test_ai/core/widgets/custom_action_button.dart';
import 'package:test_ai/core/widgets/custom_text_field.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_event.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formkey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextField(
            label: 'Email Address',
            hintText: 'name@example.com',
            prefixIconAsset: Assets.assetsImagesIconsEmailIcon,
            onSaved: (value) {
              email = value!;
            },
          ),
          Gap(16),
          CustomTextField(
            label: 'Password',
            hintText: '••••••••',
            prefixIconAsset: Assets.assetsImagesIconsLockIcon,
            onSaved: (value) {
              password = value!;
            },
          ),
          Gap(16),
          CustomActionButton(
            text: 'sign in',
            textColor: AppColors.onBackground,
            backgroundColor: AppColors.primary,
            onPressed: () {
              if (formkey.currentState!.validate()) {
                formkey.currentState!.save();
                context.read<AuthBloc>().add(
                  LoginWithEmailAndPasswordEvent(
                    email: email,
                    password: password,
                  ),
                );
              } else {
                setState(() {
                  autovalidateMode = AutovalidateMode.always;
                });
              }
            },
            trailingIcon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
