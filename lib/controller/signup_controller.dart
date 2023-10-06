import 'package:chat_app/constants.dart';
import 'package:chat_app/core/services/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SignupController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void signUp(context) async {
      isLoading = true;
    try {
    
      await APIs.auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //Navigator.of(context).pushReplacementNamed('home');
      APIs.auth.currentUser!.sendEmailVerification();
      GoRouter.of(context).pushReplacement("/login");
      passwordController.clear();
      emailController.clear();
      passwordController.clear();
      phoneController.clear();
      isLoading = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
        AwesomeDialog(
          context: context,
          dialogBackgroundColor: kprimaryColor,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Weak password',
          desc: 'The password provided is too weak.',
          btnCancelOnPress: () {},
          btnCancelText: 'Try again',
        ).show();
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
        AwesomeDialog(
          context: context,
          dialogBackgroundColor: kprimaryColor,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Email already in use',
          desc: 'The account already exists for that email.',
          btnCancelOnPress: () {},
          btnCancelText: 'Try again',
        ).show();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    isLoading = false;
  }
}
