// ignore_for_file: unused_import

import 'package:chat_app/core/services/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserSettingsController extends GetxController {
  //late UserModel userModel;
  void logout(context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await APIs.auth.signOut();
    GoRouter.of(context).pushReplacement("/login");

  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
