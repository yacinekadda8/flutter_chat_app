import 'package:flutter/material.dart';

import 'package:chat_app/constants.dart';

class Authbutton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide side;
  final void Function()? onPressed;

  const Authbutton({
    Key? key,
    required this.text,
    this.backgroundColor = kprimaryColor,
    this.foregroundColor = thiredColor,
    this.side = BorderSide.none,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
