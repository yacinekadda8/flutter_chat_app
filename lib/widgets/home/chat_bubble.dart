import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    this.topLeft = 0,
    this.isMe = false,
  });
  final double topLeft;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        //constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
        //alignment: Alignment.centerLeft,
        // width: MediaQuery.of(context).size.width * .6,
        margin: const EdgeInsets.only(top: defaultPadding / 2),
        decoration: BoxDecoration(
            color: isMe ? kbodyTextColor : kprimaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(30),
              bottomRight: const Radius.circular(30),
              topRight: const Radius.circular(30),
              topLeft: Radius.circular(topLeft),
            )),
        child: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding / 2),
          child: Text(
            'how chat bubble',
            softWrap: true,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: secondaryColor,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );
  }
}
