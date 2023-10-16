import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/inbox_controller.dart';
import 'package:chat_app/data/apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    InboxController controller = Get.put(InboxController());
    return Container(
      color: kprimaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            "Chat App",
            style: TextStyle(fontSize: 24, color: kblackColor),
          ),
          SizedBox(width: controller.mq(context).width / 3),
          IconButton(
            onPressed: () {
              controller.showMessageUpdateDialog(context);
            },
            icon: const Icon(Icons.person_add),
          ),
          IconButton(
              onPressed: () => context
                  .go('/userSettings', extra: {'usermodel': APIs.currentUser}),
              icon: const Icon(Icons.settings)),
        ]),
      ),
    );
  }
}
