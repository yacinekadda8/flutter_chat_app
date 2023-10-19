import 'package:chat_app/constants.dart';
import 'package:chat_app/core/utils/mydialogs.dart';
import 'package:chat_app/data/apis.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ChatController extends GetxController {
  List<MessageModel> messagesList = [];
  TextEditingController textEditingController = TextEditingController();

  void showEditFriendBottomSheet(context, friendId) {
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
                  "Some Actions",
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        //Navigator.pop(context);
                      },
                      child: Container(
                        color: kgreyColor,
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        margin: const EdgeInsets.only(
                          left: defaultPadding / 2,
                          right: defaultPadding / 2,
                          bottom: defaultPadding / 2,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('View profile'),
                            Icon(Icons.person_pin)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        MyDialogs.confrmationDialog(
                            context: context,
                            title: "Unfriend",
                            content:
                                "You will remove this friend by clicking the Remove button",
                            actionBtnText: "Remove",
                            onActionBtnBgColor: kRedColor,
                            onActionBtnPressed: () {
                              APIs.removeFriend(friendId);
                              GoRouter.of(context).pushReplacement('/home');
                            });
                        update();
                      },
                      child: Container(
                        color: kgreyColor,
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        margin: const EdgeInsets.only(
                          left: defaultPadding / 2,
                          right: defaultPadding / 2,
                          bottom: defaultPadding / 2,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Unfriend'),
                            Icon(Icons.person_remove)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        //Navigator.pop(context);
                      },
                      child: Container(
                        color: kgreyColor,
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        margin: const EdgeInsets.only(
                          left: defaultPadding / 2,
                          right: defaultPadding / 2,
                          bottom: defaultPadding / 2,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Block'), Icon(Icons.person_off)],
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

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
