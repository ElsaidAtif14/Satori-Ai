import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_ai/core/helper/shared_pref_helper.dart';
import 'package:test_ai/core/services/custom_bloc_observer.dart';
import 'package:test_ai/firebase_options.dart';
import 'package:test_ai/core/helper/injection_container.dart';
import 'package:test_ai/core/routing/app_router.dart';
import 'package:test_ai/core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  Bloc.observer=CustomBlocObserver();
  await SharedPrefHelper.init();

  await setupDI();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          textTheme: GoogleFonts.cairoTextTheme(ThemeData.light().textTheme),
        ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF131314),
          useMaterial3: true,
          brightness: Brightness.dark,
          textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
        ),
        themeMode: ThemeMode.dark,
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.splashView,
      ),
    );
  }
}
