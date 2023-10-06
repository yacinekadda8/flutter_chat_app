import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/core/services/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

/*
  // ========================   LOGIN WITH GOOGLE ========================

  Future signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
  }
  // ========================   LOGIN WITH EMAIL && PASSWORD ========================
*/
  void login(context) async {
    isLoading = true;
    update();
    try {
      final credential = await APIs.auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (credential.user!.emailVerified) {
        GoRouter.of(context).pushReplacement("/home");
        emailController.clear();
        passwordController.clear();
      } else {
        AwesomeDialog(
          context: context,
          dialogBackgroundColor: kprimaryColor,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Verifey Your Email',
          desc:
              "We have sent you an email. Just click on the link in this email to complete your subscription.",
          btnCancelOnPress: () {},
          btnCancelText: 'Try again',
        ).show();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        AwesomeDialog(
          context: context,
          dialogBackgroundColor: kprimaryColor,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'User not found',
          desc: 'No user found for that email.',
          btnCancelOnPress: () {},
          btnCancelText: 'Try again',
        ).show();
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        AwesomeDialog(
          context: context,
          dialogBackgroundColor: kprimaryColor,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Wrong password',
          desc: 'Wrong password provided for that user.',
          btnCancelOnPress: () {},
          btnCancelText: 'Try again',
        ).show();
      }
    }
    isLoading = false;
    update();
  }
}
