library date_picker_timeline;

import 'package:todo_app/views/widgets/date_picker_timeline/date_widget.dart';
import 'package:todo_app/views/widgets/date_picker_timeline/core/color.dart';
import 'package:todo_app/views/widgets/date_picker_timeline/core/style.dart';
import 'package:todo_app/views/widgets/date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class DatePickerTimeline extends StatefulWidget {
  DateTime currentDate;

  final double width;
  final double height;

  final TextStyle monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateChangeListener onDateChange;
  final int daysCount;
  final String locale;

  // Creates the DatePickerTimeline Widget
  DatePickerTimeline(
    this.currentDate, {
    Key key,
    this.width,
    this.height = 80,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.daysCount = 50000,
    this.onDateChange,
    this.locale = "en_US",
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePickerTimeline> {
  @override
  void initState() {
    super.initState();

    initializeDateFormatting(widget.locale, null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.daysCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // Return the Date Widget
          DateTime _date = DateTime.now().add(Duration(days: index));
          DateTime date = new DateTime(_date.year, _date.month, _date.day);
          bool isSelected = compareDate(date, widget.currentDate);

          return DateWidget(
            date: date,
            monthTextStyle:
                isSelected ? selectedMonthTextStyle : widget.monthTextStyle,
            dateTextStyle:
                isSelected ? selectedDateTextStyle : widget.dateTextStyle,
            dayTextStyle:
                isSelected ? selectedDayTextStyle : widget.dayTextStyle,
            locale: widget.locale,
            selectionColor:
                isSelected ? widget.selectionColor : Color(0x10000000),
            onDateSelected: (selectedDate) {
              // A date is selected
              if (widget.onDateChange != null) {
                widget.onDateChange(selectedDate);
              }
              setState(() {
                widget.currentDate = selectedDate;
              });
            },
          );
        },
      ),
    );
  }

  bool compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}
