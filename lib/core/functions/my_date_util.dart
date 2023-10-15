import 'package:flutter/material.dart';

class MyDateUtil {
  // fromMicrosecondsSinceEpoch string used in ChatBubble
  static String getFormatedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  // Get time of last msg  used in ChatBubble
  static String getlastmsgtime(
      {required BuildContext context, required String time}) {
    final DateTime sent = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }
    return '${getMonth(sent)} ${sent.day}';
  }

  // Get month of last msg
  static String getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'January';

      case 2:
        return 'February';

      case 3:
        return 'March';

      case 4:
        return 'April';

      case 5:
        return 'May';

      case 6:
        return 'June';

      case 7:
        return 'July';

      case 8:
        return 'August';

      case 9:
        return 'September';

      case 10:
        return 'October';

      case 11:
        return 'November';

      case 12:
        return 'December';

      default:
        return 'Invalid month';
    }
  }

  // static DateTime getFormatedDateTime(
  //     {required BuildContext context, required String time}) {
  //   final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(time) );
  //   return date;
  // }
}
