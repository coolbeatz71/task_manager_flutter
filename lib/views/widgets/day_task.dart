import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';

class DayTasksText extends StatelessWidget {
  final int countTasks;

  const DayTasksText({
    Key key,
    this.countTasks = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'You have ',
        style: TextStyle(
          color: AppColors.darkGrey,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '$countTasks ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
              fontSize: 16,
            ),
          ),
          TextSpan(text: (countTasks > 1) ? 'tasks ' : 'task '),
          TextSpan(text: 'for today'),
        ],
      ),
    );
  }
}
