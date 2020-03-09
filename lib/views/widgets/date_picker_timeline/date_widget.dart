import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/views/widgets/date_picker_timeline/gestures/tap.dart';

class DateWidget extends StatelessWidget {
  final DateTime date;
  final TextStyle monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback onDateSelected;
  final String locale;

  DateWidget({
    @required this.date,
    @required this.monthTextStyle,
    @required this.dayTextStyle,
    @required this.dateTextStyle,
    @required this.selectionColor,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: selectionColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 2.0,
            bottom: 2.0,
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat("MMM", locale).format(date).toUpperCase(), // Month
                style: monthTextStyle,
              ),
              Text(
                date.day.toString(), // Date
                style: dateTextStyle,
              ),
              Text(
                DateFormat("E", locale).format(date), // WeekDay
                style: dayTextStyle,
              )
            ],
          ),
        ),
      ),
      onTap: () {
        if (onDateSelected != null) onDateSelected(this.date);
      },
      onDoubleTap: () {
        if (onDateSelected != null) onDateSelected(null);
      },
      onLongPress: () {
        if (onDateSelected != null) onDateSelected(null);
      },
    );
  }
}
