import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onPressed,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function()? onPressed;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: defaultPadding / 2,
        right: defaultPadding / 2,
        bottom: defaultPadding / 3,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.send,
                color: kprimaryColor,
              )),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          labelText: labelText,
        ),
      ),
    );
  }
}
