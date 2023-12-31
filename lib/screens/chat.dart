import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/core/functions/my_date_util.dart';
import 'package:chat_app/data/apis.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/home/chat_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../widgets/home/chat_bubble.dart';

class Chat extends StatelessWidget {
  final UserModel userModel;
  const Chat({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.put(ChatController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              chatAppBar(controller, context, userModel),
              Expanded(
                  child: StreamBuilder(
                      stream: APIs.getAllMessages(userModel),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          // if data is loading
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const Center(child: SizedBox());

                          // if some or all data load
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            controller.messagesList = data
                                    ?.map(
                                        (e) => MessageModel.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (controller.messagesList.isNotEmpty) {
                              return ListView.builder(
                                itemCount: controller.messagesList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ChatBubble(
                                    messageModel:
                                        controller.messagesList[index],
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  "Start Chating! ✋",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: koilColor,
                                  ),
                                ),
                              );
                            }
                        }
                      }))
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        //padding: const EdgeInsets.all(defaultPadding / 2),
        height: 60,
        width: double.infinity,
        //color: Colors.red,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(left: defaultPadding * 2),
        alignment: Alignment.bottomCenter,
        child: ChatTextField(
          onPressed: () {
            if (controller.textEditingController.text.isNotEmpty) {
              APIs.sendMsg(userModel, controller.textEditingController.text);
              controller.textEditingController.clear();
            }
          },
          labelText: "Aa",
          controller: controller.textEditingController,
        ),
      ),
    );
  }
}

Widget chatAppBar(controller, BuildContext context, UserModel userModel) {
  return StreamBuilder(
      stream: APIs.getUserInfo(userModel),
      builder: (context, snapshot) {
        final data = snapshot.data?.docs;
        final list =
            data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];

        return Row(children: [
          // *******************  Back Button ************************//
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          // *******************  Image of User ************************//
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              height: 35,
              width: 35,
              fit: BoxFit.cover,
              // *******************  Image of User ************************//
              imageUrl: list.isNotEmpty
                  ? list[0].image
                  : userModel.image, //userModel.image.toString(),
              //placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(Icons.person)),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // *******************  Name of User ************************//
                list.isNotEmpty ? list[0].name : userModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kblackColor,
                ),
              ),
              Text(
                // *******************  lastActive Status ************************//
                list.isNotEmpty
                    ? list[0].isOnline
                        ? "Active now"
                        : MyDateUtil.getLastActiveTime(
                            context: context, lastActive: list[0].lastActive)
                    : userModel.lastActive,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: kblackColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              controller.showEditFriendBottomSheet(context, userModel.id);
            },
            icon: const Icon(Icons.menu),
          ),
        ]);
      });
}
