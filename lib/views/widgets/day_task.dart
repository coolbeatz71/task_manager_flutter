import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/helpers/colors.dart';

class DayTasksText extends StatelessWidget {
  final int countTasks;

  const DayTasksText({
    Key key,
    this.countTasks = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 12.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: SvgPicture.asset(
            'assets/images/to-do-list.svg',
            placeholderBuilder: (context) => SpinKitThreeBounce(
              color: AppColors.primary,
              size: 30,
            ),
            width: 30,
            height: 30,
          ),
        ),
        Container(
          // decoration: BoxDecoration(border: Border.all()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: '$countTasks',
                  style: TextStyle(
                    color: AppColors.dark,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w200,
                    fontSize: 38,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: (countTasks > 1) ? 'active tasks ' : 'active task ',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: AppColors.darkGrey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Today ${DateFormat('yyyy MMMM dd').format(DateTime.now())}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGrey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
