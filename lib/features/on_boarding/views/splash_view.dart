import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_ai/core/constants/constant.dart';
import 'package:test_ai/core/helper/extension.dart';
import 'package:test_ai/core/helper/shared_pref_helper.dart';
import 'package:test_ai/core/routing/routes.dart';
import 'package:test_ai/core/services/firebase_auth_services.dart';
import 'package:test_ai/core/widgets/satori_title.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    exeuceteNavigtion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/Ghostsmart.json'),
            const SatoriTitle(),
          ],
        ),
      ),
    );
  }

  Future<void> exeuceteNavigtion() async {
    bool isOnBoardingViewSeen = SharedPrefHelper.getBool(onBoardingViewSeenKey);

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      if (isOnBoardingViewSeen) {
        var isLoggedin = FirebaseAuthServices().isUserLoggedIn();
        if (isLoggedin) {
          context.pushReplacementNamed(Routes.chatView);
        } else {
          context.pushReplacementNamed(Routes.signupView);
        }
      } else {
        context.pushReplacementNamed(Routes.onBoardingView);
      }
    });
  }
}
