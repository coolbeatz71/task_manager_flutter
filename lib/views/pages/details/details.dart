import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/pages/details/completion_task.dart';
import 'package:todo_app/views/pages/details/reminder_status.dart';
import 'package:todo_app/views/pages/details/task_list.dart';
import 'package:todo_app/views/widgets/add_task_fb.dart';
import 'package:todo_app/views/widgets/day_task.dart';

class Details extends StatelessWidget {
  final Task task;

  const Details({Key key, @required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Task details'),
        backgroundColor: AppColors.primary,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DayTasksText(),
                      AddTaskFloatingButton(
                        fromPage: TaskPageStatus.details,
                        icon: Icons.edit,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TaskCompletionStatus(task: task),
                      Theme(
                        data: ThemeData(accentColor: Colors.white),
                        child: FloatingActionButton(
                          heroTag: 'details-delete-task-${task.id}',
                          elevation: 0,
                          onPressed: () {},
                          mini: true,
                          child: FaIcon(
                            FontAwesomeIcons.solidTrashAlt,
                            color: AppColors.darkGrey,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TaskReminderStatus(task: task),
                Divider(),
                TaskList(task: task)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
