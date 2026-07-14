import 'package:flutter/cupertino.dart'; // سحبنا مكتبة الكوبرتينو عشان المؤشر
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_ai/core/constants/constant.dart';
import 'package:test_ai/core/helper/extension.dart';
import 'package:test_ai/core/routing/routes.dart';
import 'package:test_ai/core/widgets/custom_snak_bar.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_state.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/login_devider.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/sign_up_form.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/sign_up_header.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/sign_with_google_button.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showCustomSnackBar(
            context,
            message: state.errorMessage,
            backgroundColor: Colors.red,
          );
        }

        if (state is AuthSuccess) {
          showCustomSnackBar(
            context,
            message: 'تم إنشاء الحساب بنجاح',
            backgroundColor: Colors.green,
          );
          context.pushNamedAndRemoveUntil(
            Routes.chatView,
            predicate: (route) => false,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AuthLoading,
          // التغيير هنا: ضيفنا الكوبرتينو إنديكيتور وخلينا حجمه مناسب
          progressIndicator: const CupertinoActivityIndicator(
            radius: 16, // كبرنا حجم اللودينج شوية عشان يظهر بوضوح
          ),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kVerticalPadding,
              horizontal: khorizontalPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SignUpHeader(),
                  const Gap(32),
                  const SignUpForm(),
                  const LoginDevider(),
                  SignWithGoogleButton(),
                  const Gap(32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
