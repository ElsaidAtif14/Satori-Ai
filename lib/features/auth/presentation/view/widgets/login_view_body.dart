import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // تأكد من عمل import للمكتبة دي
import 'package:test_ai/core/constants/constant.dart';
import 'package:test_ai/core/helper/extension.dart';
import 'package:test_ai/core/routing/routes.dart';
import 'package:test_ai/core/widgets/custom_snak_bar.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_state.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/login_container.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/login_header.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

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
            message: 'تم تسجيل الدخول بنجاح',
            backgroundColor: Colors.green,
          );
          context.pushNamedAndRemoveUntil(Routes.chatView, predicate: (route) => false);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AuthLoading,
          color: Colors.transparent,
          progressIndicator: const CupertinoActivityIndicator(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kVerticalPadding,
              horizontal: khorizontalPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: const [LoginHeader(), Gap(32), LoginContainer()],
              ),
            ),
          ),
        );
      },
    );
  }
}
