import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/views/pages/home/bottomsheet.dart';

enum TaskPageStatus {
  all,
  completed,
  active,
}

class Utils {
  Utils();

  Utils.showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BottomSheetContainer(),
    );
  }

  static DateTime timeToDateTime(TimeOfDay time) {
    return DateTime(0, 0, 0, time.hour, time.minute);
  }

  static String formatTime(TimeOfDay time) {
    return DateFormat.jm().format(timeToDateTime(time));
  }

  /// Convert a date [dateTime] to [String]
  static String dateToString(DateTime date) => date.toString();

  /// Convert a date [String] to [DateTime]
  static DateTime toDateTime(String date) => DateTime.parse(date);

  /// Convert a date to "H:mm AM/PM" format
  static TimeOfDay toTime(String date) {
    return TimeOfDay.fromDateTime(DateTime.parse(date));
  }

  /// get Hour from a time [TimeOfDay]
  static String getHour(TimeOfDay time) {
    String hour = formatTime(time).split(":")[0];
    return (hour.length == 1) ? '0$hour' : hour;
  }

  /// get Minutes from a time [TimeOfDay]
  static String getMinutes(TimeOfDay time) => formatTime(time).split(":")[1];
}
