import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/core/services/apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class UserSettingsController extends GetxController {
  final globalKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  String? image;

  // device size
  Size mq(context) {
    return MediaQuery.of(context).size;
  }

  // late UserModel userModel;

  // logout
  void logout(context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await APIs.auth.signOut();
    GoRouter.of(context).pushReplacement("/login");
  }

  void showEditImgBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  "Update Profile Picture",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kblackColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final XFile? img =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (img != null) {
                          log("Image Path: ${img.path} -- MimeType: ${img.mimeType}");
                          image = img.path;
                          update();
                        }
                        //Navigator For hiding showEditImgBottomSheet
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: koilColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(
                          Icons.collections_rounded,
                          color: kprimaryColor,
                          size: 50,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final XFile? img =
                            await picker.pickImage(source: ImageSource.camera);
                        if (img != null) {
                          log("Image Path: ${img.path}");
                          image = img.path;
                          update();
                        }
                        //Navigator For hiding showEditImgBottomSheet
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: koilColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(
                          Icons.camera,
                          color: kprimaryColor,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding * 2),
            ],
          );
        });
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
