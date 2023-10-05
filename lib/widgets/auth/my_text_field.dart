import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.emailController,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController emailController;
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
        controller: emailController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          labelText: labelText,
        ),
      ),
    );
  }
}
