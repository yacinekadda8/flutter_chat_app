import 'package:chat_app/core/services/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class InboxController extends GetxController {
  void logout(context) async {
    //GoogleSignIn googleSignIn = GoogleSignIn();
    //googleSignIn.disconnect();
    await APIs.auth.signOut();
    GoRouter.of(context).pushReplacement("/login");
  }
}
