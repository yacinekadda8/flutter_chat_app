import 'package:chat_app/constants.dart';
import 'package:chat_app/core/services/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/friend_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class InboxController extends GetxController {
  late List<UserModel> list;
  
  void logout(context) async {
    //GoogleSignIn googleSignIn = GoogleSignIn();
    //googleSignIn.disconnect();
    await APIs.auth.signOut();
    GoRouter.of(context).pushReplacement("/login");
  }
}
