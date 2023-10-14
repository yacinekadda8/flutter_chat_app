import 'package:flutter/material.dart';

class MyDateUtil {
  // fromMicrosecondsSinceEpoch string
  static String getFormatedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(time) );
    return TimeOfDay.fromDateTime(date).format(context);
  }
  static DateTime getFormatedDateTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(time) );
    return date;
  }
}
