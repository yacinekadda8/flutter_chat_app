import 'package:chat_app/screens/auth/login.dart';
import 'package:chat_app/screens/auth/reset_password.dart';
import 'package:chat_app/screens/auth/signup.dart';
import 'package:chat_app/screens/chat_details.dart';
import 'package:chat_app/screens/home.dart';

import 'package:chat_app/screens/welcome/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.emailVerified
              ? const HomeScreen ()
              : const WelcomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const Login();
            },
          ),
          GoRoute(
            path: "signup",
            builder: (BuildContext context, GoRouterState state) {
              return const Signup();
            },
          ),
          GoRoute(
            path: "resetPassword",
            builder: (BuildContext context, GoRouterState state) {
              return const ResetPassword();
            },
          ),
          GoRoute(
            path: "home",
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
          GoRoute(
            path: "chatDetails",
            builder: (BuildContext context, GoRouterState state) {
              return const ChatDetails();
            },
          ),
        ],
      ),
    ],
  );
}
