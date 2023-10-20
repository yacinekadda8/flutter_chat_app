import 'package:chat_app/core/functions/my_date_util.dart';
import 'package:chat_app/core/utils/device_size.dart';
import 'package:chat_app/data/apis.dart';
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //CircleAvatar(backgroundImage: NetworkImage(userModel.image)),
                      CircleUserImage(userModel: widget.userModel),
                      const SizedBox(width: defaultPadding),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                             width: DeviceSize.mq(context).width / 3,
                            child: Text(
                              widget.userModel.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kSocendColor,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: DeviceSize.mq(context).width / 3,
                                child: Text(
                                  messageModel != null
                                      ? messageModel!.msg
                                      : "Start Chating ✋",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              const SizedBox(width: defaultPadding / 2),
                              if (messageModel != null)
                                Text(
                                  MyDateUtil.getLastMessageTime(
                                      context: context,
                                      time: messageModel!.sent),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                            ],
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
