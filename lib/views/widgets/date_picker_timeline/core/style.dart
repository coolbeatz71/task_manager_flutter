import 'package:flutter/material.dart';
import 'package:todo_app/views/widgets/date_picker_timeline/core/color.dart';
import 'package:todo_app/views/widgets/date_picker_timeline/core/dimen.dart';

const TextStyle defaultMonthTextStyle = TextStyle(
  color: AppColors.defaultMonthColor,
  fontSize: Dimen.monthTextSize,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.w600,
);

const TextStyle defaultDateTextStyle = TextStyle(
  color: AppColors.defaultDateColor,
  fontSize: Dimen.dateTextSize,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.w700,
);

const TextStyle defaultDayTextStyle = TextStyle(
  color: AppColors.defaultDayColor,
  fontSize: Dimen.dayTextSize,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.w600,
);

const TextStyle selectedMonthTextStyle = TextStyle(
  color: Colors.white,
  fontSize: Dimen.monthTextSize,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.w600,
);

const TextStyle selectedDateTextStyle = TextStyle(
  color: Colors.white,
  fontSize: Dimen.dateTextSize,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.w700,
);

const TextStyle selectedDayTextStyle = TextStyle(
  color: Colors.white,
  fontSize: Dimen.dayTextSize,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.w600,
);
