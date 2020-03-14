import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/pages/home/bottomsheet.dart';

enum TaskPageStatus {
  all,
  completed,
  active,
  details,
}

class Utils {
  Utils();

  Utils.showBottomSheet(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BottomSheetContainer(task: task),
    );
  }

  static DateTime timeToDateTime(
    TimeOfDay time, {
    year = 0,
    month = 0,
    day = 0,
  }) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  static String formatTime(TimeOfDay time) {
    return DateFormat.jm().format(timeToDateTime(time));
  }

  static String dateToString(DateTime date) => date.toString();

  static DateTime toDate(String date) => DateTime.parse(date);

  static String getHour(TimeOfDay time) {
    String hour = formatTime(time).split(":")[0];
    return (hour.length == 1) ? '0$hour' : hour;
  }

  static TimeOfDay toTime(String time) {
    String hour = time.split(':')[0];
    String rest = time.split(':')[1];
    String minute = rest.split(' ')[0];
    String period = rest.split(' ')[1];

    if (period == 'PM') {
      int parsedHour = int.parse(hour) + 12;
      hour = parsedHour.toString();
    }

    return TimeOfDay(
      hour: int.parse(hour),
      minute: int.parse(minute),
    );
  }

  static String getMinutes(TimeOfDay time) => formatTime(time).split(":")[1];

  Future<Null> selectDate(
    BuildContext context,
    TextEditingController date,
  ) async {
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate = picked;
      date.value = TextEditingValue(
        text: dateToString(picked).substring(0, 10),
      );
    }

    return null;
  }

  Future<String> selectTime(
    BuildContext context,
    TextEditingController time,
  ) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );
      },
    );

    if (picked != null) {
      selectedTime = picked;
      time.value = TextEditingValue(
        text: formatTime(picked),
      );
    }

    return "";
  }

  static void showToast({@required String message, bool success = true}) {
    FlutterFlexibleToast.showToast(
      message: message,
      toastLength: Toast.LENGTH_LONG,
      toastGravity: ToastGravity.BOTTOM,
      icon: ICON.SUCCESS,
      radius: 10,
      elevation: 0,
      imageSize: 16,
      textColor: Colors.white,
      backgroundColor: success ? AppColors.greenAccent : Colors.red,
      timeInSeconds: 2,
    );
  }

  static bool compareDate(DateTime date1, DateTime date2) {
    if (date2 != null) {
      return date1.day == date2.day &&
          date1.month == date2.month &&
          date1.year == date2.year;
    }

    return false;
  }

  static int randomNumber() {
    Random rng = new Random();
    return rng.nextInt(900000000) + 100000000;
  }
}
