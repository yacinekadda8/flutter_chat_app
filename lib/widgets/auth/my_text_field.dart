import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController controller;
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
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          labelText: labelText,
        ),
      ),
    );
  }
}
