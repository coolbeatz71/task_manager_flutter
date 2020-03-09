import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/pages/details/task_list_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key key,
    @required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      height: 420,
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: <Widget>[
            TaskListTile(
              title: 'Title',
              subTitle: task.title,
              leadingIcon: Icons.assignment,
            ),
            TaskListTile(
              title: 'Note',
              subTitle: task.note,
              leadingIcon: Icons.subject,
            ),
            TaskListTile(
              title: 'Date',
              subTitle: DateFormat('yyyy MMMM dd').format(task.date),
              leadingIcon: Icons.calendar_today,
            ),
            TaskListTile(
              title: 'Time',
              subTitle: Utils.formatTime(task.time),
              leadingIcon: Icons.alarm,
            ),
          ],
        ).toList(),
      ), //
    );
  }
}
