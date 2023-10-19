import 'package:chat_app/constants.dart';
import 'package:chat_app/data/apis.dart';
import 'package:chat_app/core/utils/mydialogs.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class InboxController extends GetxController {
  late List<UserModel> list;
  final List<UserModel> searchList = [];
  GoogleSignIn googleSignIn = GoogleSignIn();

  Size mq(context) {
    return MediaQuery.of(context).size;
  }

  void logout(context) async {
    googleSignIn.disconnect();
    await APIs.auth.signOut();
    GoRouter.of(context).pushReplacement("/login");
  }

  //dialog for updating message content
  void showMessageUpdateDialog(BuildContext context) {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: kWhiteColor,
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),

              //title
              title: const Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: kprimaryColor,
                    size: 24,
                  ),
                  SizedBox(width: defaultPadding / 2),
                  Text('Add Friend', style: TextStyle(color: koilColor))
                ],
              ),

              //content
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: "Add friend email",
                    prefixIcon: const Icon(Icons.email, color: kprimaryColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: koilColor, fontSize: 16),
                    )),

                //add button
                MaterialButton(
                    color: kprimaryColor,
                    onPressed: () async {
                      //hide alert dialog
                      Navigator.pop(context);
                      // add new friend
                      if (email.isNotEmpty) {
                        await APIs.addNewFriend(email).then((value) {
                          if (!value) {
                            return MyDialogs.showSnackbar(
                                context, "User Doesn't Exist");
                          } else {
                            return MyDialogs.showSnackbar(context, "Done 😍");
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: koilColor, fontSize: 16),
                    ))
              ],
            ));
  }

  void deleteChatInConversation(BuildContext context, UserModel user) {
    MyDialogs.confrmationDialog(
        context: context,
        title: "Delete Chat In Conversation",
        content:
            "Are you sure you want to delete the chat in this Conversation ?",
        actionBtnText: "Delete",
        onActionBtnBgColor: kRedColor,
        onActionBtnPressed: () async {
          Navigator.of(context).pop();
          // Call the deleteChatConversation function when the user confirms
          await APIs.deleteChatInConversation(user);
        });
    update();
  }
  // @override
  // void onInit() {
  //   super.onInit();
  //   APIs.getCurrentUserInfo();
  //   update();
  // }
}
