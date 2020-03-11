import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/models/task.dart';

class TaskReminderStatus extends StatelessWidget {
  final Task task;

  const TaskReminderStatus({
    Key key,
    @required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(accentColor: Colors.white),
                  child: FloatingActionButton(
                    heroTag: 'details-reminder-task-${task.id}',
                    elevation: 0,
                    onPressed: () {},
                    mini: true,
                    child: FaIcon(
                      FontAwesomeIcons.solidBell,
                      color: AppColors.darkGrey,
                      size: 20,
                    ),
                  ),
                ),
                Text(
                  'Reminder activated',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: AppColors.darkGrey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
