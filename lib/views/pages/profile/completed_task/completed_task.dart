import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/services/firestore.dart';
import 'package:todo_app/views/widgets/add_task_fb.dart';
import 'package:todo_app/views/widgets/date_picker_timeline/date_picker_timeline.dart';
import 'package:todo_app/views/widgets/day_task.dart';
import 'package:todo_app/views/widgets/task_list.dart';

class CompletedTask extends StatefulWidget {
  final String title;

  const CompletedTask({Key key, @required this.title}) : super(key: key);

  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<CompletedTask> {
  final pageStatus = TaskPageStatus.completed;
  DateTime _selectedValue;

  @override
  Widget build(BuildContext context) {
    Stream taskStream = FirestoreService().getTaskByStatus(
      'c9ad90ca-7071-41c4-bb42-7945ea330a3a',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.primary,
        leading: Icon(Icons.event_note),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                DatePickerTimeline(
                  _selectedValue,
                  onDateChange: (date) {
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
                Divider(),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DayTasksText(),
                      AddTaskFloatingButton(fromPage: TaskPageStatus.completed),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  height: MediaQuery.of(context).size.height -
                      (7 * kBottomNavigationBarHeight),
                  child: TaskList(
                    taskStream: taskStream,
                    pageStatus: pageStatus,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
