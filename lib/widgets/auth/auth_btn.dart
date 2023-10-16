import 'package:flutter/material.dart';

import 'package:chat_app/constants.dart';

class Authbutton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide side;
  final void Function()? onPressed;
  final double horizontal;
  final double vertical;

  const Authbutton({
    Key? key,
    required this.text,
    this.backgroundColor = kprimaryColor,
    this.foregroundColor = kWhiteColor,
    this.side = BorderSide.none,
    required this.onPressed,
    this.horizontal = 10,
    this.vertical = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor, // background color
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            side: side,
            borderRadius:
                BorderRadius.circular(15), // Set border radius to zero
          ), // text color
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
