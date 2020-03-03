import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/services/firestore.dart';
import 'package:todo_app/views/pages/profile/all_task/add_task_fb.dart';
import 'package:todo_app/views/pages/profile/all_task/day_task.dart';
import 'package:todo_app/views/pages/profile/all_task/task_list.dart';
import 'package:todo_app/views/widgets/date_picker_timeline/date_picker_timeline.dart';

class AllTask extends StatefulWidget {
  final String title;

  const AllTask({Key key, @required this.title}) : super(key: key);

  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  final pageStatus = TaskPageStatus.all;
  DateTime _selectedValue = DateTime.now();
  bool isFilterSelected = false;

  @override
  Widget build(BuildContext context) {
    Stream taskStream = FirestoreService().getTaskByUser(
      'c9ad90ca-7071-41c4-bb42-7945ea330a3a',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.primary,
        leading: Icon(Icons.event_note),
        actions: <Widget>[
          Theme(
            data: ThemeData(
              accentColor: Colors.transparent,
            ),
            child: FloatingActionButton(
              mini: true,
              elevation: 0,
              tooltip: 'Filter by date',
              child: Icon(Icons.date_range, size: 22),
              backgroundColor:
                  isFilterSelected ? AppColors.primaryAccent : null,
              onPressed: () {
                setState(() {
                  isFilterSelected = !isFilterSelected;
                });
              },
            ),
          ),
          IconButton(
            tooltip: 'Mark All as done',
            icon: Icon(Icons.playlist_add_check),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Visibility(
              maintainSize: false,
              maintainAnimation: true,
              maintainState: true,
              visible: isFilterSelected,
              child: DatePickerTimeline(
                _selectedValue,
                onDateChange: (date) {
                  setState(() {
                    _selectedValue = date;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DayTasksText(),
                      AddTaskFloatingButton(),
                    ],
                  ),
                  Divider(color: AppColors.darkGrey),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.69,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TaskList(
                      taskStream: taskStream,
                      pageStatus: pageStatus,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
