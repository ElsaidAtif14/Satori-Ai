import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:test_ai/constants/assets.dart';
import 'package:test_ai/core/utils/app_colors.dart';
import 'package:test_ai/core/widgets/custom_action_button.dart';
import 'package:test_ai/core/widgets/custom_text_field.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_event.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> formkey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password, name;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextField(
            fillColor: Color(0xff1E1E20),
            label: 'Full Name',
            hintText: 'John Die',
            textColor: Colors.white,
            prefixIconAsset: Assets.assetsImagesIconsPersonIcon,
            onSaved: (value) {
              name = value!;
            },
          ),
          Gap(24),
          CustomTextField(
            fillColor: Color(0xff1E1E20),
            label: 'Email Address',
            hintText: 'name@example.com',
            textColor: Colors.white,
            prefixIconAsset: Assets.assetsImagesIconsEmailIcon,
            onSaved: (value) {
              email = value!;
            },
          ),
          Gap(24),
          CustomTextField(
            fillColor: Color(0xff1E1E20),
            label: 'Password',
            hintText: '••••••••',
            textColor: Colors.white,
            isPassword: true,

            prefixIconAsset: Assets.assetsImagesIconsLockIcon,
            onSaved: (value) {
              password = value!;
            },
          ),
          Gap(24),
          CustomActionButton(
            text: 'sign in',
            textColor: AppColors.onBackground,
            backgroundColor: AppColors.primary,
            onPressed: () {
              if (formkey.currentState!.validate()) {
                formkey.currentState!.save();
                context.read<AuthBloc>().add(
                  RegisterWithEmailAndPasswordEvent(
                    email: email,
                    password: password,
                    name: name,
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
