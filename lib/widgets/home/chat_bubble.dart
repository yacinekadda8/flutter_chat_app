import 'package:chat_app/constants.dart';
import 'package:chat_app/core/functions/my_date_util.dart';
import 'package:chat_app/data/apis.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:flutter/material.dart';

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
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Row(
            children: [
              SizedBox(width: mq.width * .04),
              Text(MyDateUtil.getFormattedTime(
                  context: context, time: widget.messageModel.sent)),
              //double tick icon for message read
              widget.messageModel.read.isNotEmpty == false
                  //sent
                  ? const Icon(Icons.done, color: kgreyColor)
                  // seen
                  : const Icon(Icons.done_all_rounded, color: kSocendColor)
            ],
          ),
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
    //update last read message if sender and receiver are different
    if (widget.messageModel.read.isEmpty) {
      APIs.updateReadStatus(widget.messageModel);
    }

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
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
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
          padding: EdgeInsets.only(right: mq.width * .04, top: 25),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.messageModel.sent),
            style: const TextStyle(color: kprimaryColor),
          ),
        ),
      ],
    );
  }
}
