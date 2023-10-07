import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/home_controller.dart';
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
    List<UserModel> list = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat App"),
        actions: [
          IconButton(
              onPressed: () {
                controller.logout(context);
              },
              icon: const Icon(Icons.logout))
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
                        list = data
                                ?.map((e) => UserModel.fromJson(e.data()))
                                .toList() ??
                            [];

                        if (list.isNotEmpty) {
                          return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FriendMsgCard(userModel: list[index]);
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
