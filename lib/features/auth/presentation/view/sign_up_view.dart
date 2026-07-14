import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ai/core/helper/injection_container.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:test_ai/features/auth/presentation/view/widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: const Scaffold(body: SignUpViewBody()),
    );
  }
}
