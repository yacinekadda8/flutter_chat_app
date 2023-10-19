import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class MyDialogs {
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Colors.blue.withOpacity(.8),
        behavior: SnackBarBehavior.floating));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
  }

  static void confrmationDialog(
      {required BuildContext context,
      required String title,
      required String content,
      required String actionBtnText,
      Color? onActionBtnBgColor,
      void Function()? onActionBtnPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: koilColor,
          title: Text(
            title,
            style: const TextStyle(color: kprimaryColor),
          ),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: onActionBtnBgColor,// kprimaryColor,
                // foregroundColor: kprimaryColor,
              ),
              onPressed: onActionBtnPressed,
              child: Text(
                actionBtnText,
                style: const TextStyle(color: kWhiteColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
