import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/views/widgets/date_picker_timeline/core/dimen.dart';

const TextStyle defaultMonthTextStyle = TextStyle(
  color: AppColors.darkGrey,
  fontSize: Dimen.monthTextSize,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.w600,
);

const TextStyle defaultDateTextStyle = TextStyle(
  color: AppColors.dark,
  fontSize: Dimen.dateTextSize,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.w700,
);

const TextStyle defaultDayTextStyle = TextStyle(
  color: AppColors.darkGrey,
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
