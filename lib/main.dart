// ignore_for_file: avoid_print

import 'package:chat_app/constants.dart';
import 'package:chat_app/core/services/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/utils/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Ideal time to initialize
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    APIs.auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    return ScreenUtilInit(
        builder: (context, child) => MaterialApp.router(
              title: 'Flutter Chat App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  backgroundColor: kprimaryColor,
                ),
                colorScheme: ColorScheme.fromSeed(seedColor: kprimaryColor),
                useMaterial3: true,
                scaffoldBackgroundColor: kthiredColor,
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: Colors.white)
                        .copyWith(
                          bodyLarge: const TextStyle(color: kbodyTextColor),
                          bodyMedium: const TextStyle(color: kbodyTextColor),
                          displayLarge: const TextStyle(color: kthiredColor),
                          displayMedium: const TextStyle(color: kthiredColor),
                        ),
              ),
              routerConfig: AppRouter.router,
            ));
  }
}
