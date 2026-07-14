import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ai/core/helper/injection_container.dart';
import 'package:test_ai/core/routing/routes.dart';
import 'package:test_ai/features/auth/presentation/view/login_view.dart';
import 'package:test_ai/features/auth/presentation/view/sign_up_view.dart';
import 'package:test_ai/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:test_ai/features/chat/presentation/pages/chat_view.dart';
import 'package:test_ai/features/on_boarding/views/on_boarding_view.dart';
import 'package:test_ai/features/on_boarding/views/splash_view.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.signupView:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.onBoardingView:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.chatView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
        create: (context) => sl<ChatBloc>(),
            child: const ChatView(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
