import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: highlightColor,
      content: Text(message),
      duration: const Duration(seconds:4),
    ),
  );
}