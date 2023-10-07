import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/inbox_controller.dart';
import 'package:chat_app/core/services/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/friend_msg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    InboxController controller = Get.put(InboxController());
    controller.list = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat App"),
        actions: [
          IconButton(
              //onPressed: () => controller.logout(context),
              onPressed: () => context
                  .go('/userSettings', extra: {'usermodel':controller.list[0]}),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding),
            const Text(
              "Inbox",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),
            const SizedBox(height: defaultPadding),
            Expanded(
              child: StreamBuilder(
                  stream: APIs.firestore.collection("users").snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      // if data is loading
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(child: CircularProgressIndicator());

                      // if some or all data load
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        controller.list = data
                                ?.map((e) => UserModel.fromJson(e.data()))
                                .toList() ??
                            [];

                        if (controller.list.isNotEmpty) {
                          return ListView.builder(
                            itemCount: controller.list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FriendMsgCard(
                                  userModel: controller.list[index]);
                            },
                          );
                        } else {
                          return const Text(
                            "No Data yet...",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          );
                        }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
