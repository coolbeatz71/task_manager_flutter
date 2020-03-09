import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/firestore.dart';

class DayTasksText extends StatelessWidget {
  const DayTasksText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream taskStream = FirestoreService().getTaskByUser(
      'c9ad90ca-7071-41c4-bb42-7945ea330a3a',
    );

    return StreamBuilder<Object>(
        stream: taskStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Task> taskList = snapshot.data;
          int countTasks = snapshot.hasData
              ? taskList.where((item) => item.isCompleted == false).length
              : 0;

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
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    'assets/images/to-do-list.svg',
                    placeholderBuilder: (context) => SpinKitThreeBounce(
                      color: AppColors.primary,
                      size: 18,
                    ),
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              Container(
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
                            text: (countTasks > 1)
                                ? 'active tasks '
                                : 'active task ',
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
        });
  }
}
