import 'package:chat_app/constants.dart';
import 'package:chat_app/core/functions/my_date_util.dart';
import 'package:chat_app/core/services/apis.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    super.key,
    required this.messageModel,
  });
  final MessageModel messageModel;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return APIs.user.uid == widget.messageModel.fromid
        ? userGrey()
        : userGreen();
  }

  Widget userGrey() {
    Size mq = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: mq.width * .04),
            Text(MyDateUtil.getFormatedTime(
                context: context, time: widget.messageModel.sent)),
            if (widget.messageModel.read == '')
              const Icon(
                Icons.done_all_rounded,
                color: highlightColor,
              ),
          ],
        ),
        Flexible(
          child: Container(
              padding: EdgeInsets.all(mq.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: mq.width * .04, vertical: mq.height * .01),
              decoration: const BoxDecoration(
                  // msg bg color
                  color: kgreyColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(0),
                    topLeft: Radius.circular(30),
                  )),
              child: Text(
                widget.messageModel.msg,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kblackColor,
                  overflow: TextOverflow.visible,
                ),
              )),
        ),
      ],
    );
  }

  Widget userGreen() {
    Size mq = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              padding: EdgeInsets.all(mq.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: mq.width * .04, vertical: mq.height * .01),
              decoration: const BoxDecoration(
                  // msg bg color
                  color: kprimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(0),
                  )),
              child: Text(
                widget.messageModel.msg,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kblackColor,
                  overflow: TextOverflow.visible,
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 24),
          child: Text(
            MyDateUtil.getFormatedTime(
                context: context, time: widget.messageModel.sent),
            style: TextStyle(color: kprimaryColor),
          ),
        ),
        if (widget.messageModel.read.isNotEmpty)
          const Icon(
            Icons.done_all_rounded,
            color: highlightColor,
          ),
      ],
    );
  }
}
