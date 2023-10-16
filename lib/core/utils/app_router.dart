import 'package:chat_app/data/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/screens/auth/login.dart';
import 'package:chat_app/screens/auth/reset_password.dart';
import 'package:chat_app/screens/auth/signup.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/requests.dart';
import 'package:chat_app/screens/user_settings.dart';

import 'package:chat_app/screens/welcome/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return APIs.auth.currentUser != null &&
                  APIs.auth.currentUser!.emailVerified
              ? const HomeScreen()
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
              //final userModel = APIs.currentUser;
              final userModel = (state.extra
                  as Map<String, dynamic>)['usermodel'] as UserModel;
              return Chat(userModel: userModel);
            },
          ),
          GoRoute(
            path: "userSettings",
            builder: (BuildContext context, GoRouterState state) {
              final userModel = APIs.currentUser;
              // final userModel = (state.extra
              //     as Map<String, dynamic>)['usermodel'] as UserModel;
              return UserSettings(userModel: userModel);
            },
          ),
          GoRoute(
            path: "pendingRequests",
            builder: (BuildContext context, GoRouterState state) {
              return const Requests();
            },
          ),
        ],
      ),
    ],
  );
}
