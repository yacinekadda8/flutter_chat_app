// ignore_for_file: unused_import

import 'package:chat_app/constants.dart';
import 'package:chat_app/core/services/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserSettingsController extends GetxController {
  final globalKey = GlobalKey<FormState>();
  Size mq(context) {
    return MediaQuery.of(context).size;
  }

  //late UserModel userModel;
  void logout(context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await APIs.auth.signOut();
    GoRouter.of(context).pushReplacement("/login");
  }

  void showEditImgBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "Update Profile Picture",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Icon(
                          Icons.collections_rounded,
                          color: highlightColor,
                          size: 40,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Icon(
                          Icons.camera,
                          color: highlightColor,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: defaultPadding * 2),
            ],
          );
        });
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
