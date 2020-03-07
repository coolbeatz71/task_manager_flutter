import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';

class TimeBoard extends StatelessWidget {
  final String hour;
  final String minute; // should contains PM or AM
  final page;
  final bool isCompleted;

  const TimeBoard({
    Key key,
    this.hour,
    this.minute,
    this.page,
    this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color:
            (page == TaskPageStatus.active) ? AppColors.primary : Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$hour',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: (page == TaskPageStatus.active)
                  ? Colors.white
                  : Colors.black45,
            ),
          ),
          Text(
            '$minute',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: (page == TaskPageStatus.active)
                  ? Colors.white
                  : Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}
