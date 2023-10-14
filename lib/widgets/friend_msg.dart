import 'package:chat_app/core/services/apis.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:chat_app/constants.dart';
import 'package:chat_app/data/models/user_model.dart';

import 'circel_user_image.dart';

class FriendMsgCard extends StatefulWidget {
  final UserModel userModel;
  const FriendMsgCard({
    super.key,
    required this.userModel,
  });

  @override
  State<FriendMsgCard> createState() => _FriendMsgCardState();
}

class _FriendMsgCardState extends State<FriendMsgCard> {
  MessageModel? messageModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          GoRouter.of(context)
              .push("/chatDetails", extra: {"usermodel": widget.userModel});
        },
        child: StreamBuilder(
          stream: APIs.getLastMsg(widget.userModel),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list =
                data?.map((e) => MessageModel.fromJson(e.data())).toList() ??
                    [];
            if (list.isNotEmpty) messageModel = list[0];

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  //color: kbodyTextColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //CircleAvatar(backgroundImage: NetworkImage(userModel.image)),
                      CircleUserImage(userModel: widget.userModel),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userModel.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: highlightColor,
                            ),
                          ),
                          Text(
                            messageModel != null
                                ? messageModel!.msg
                                : "Start Chating ✋",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "6:06",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: kprimaryColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
                              "1",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding),
                const Divider()
              ],
            );
          },
        ));
  }
}
