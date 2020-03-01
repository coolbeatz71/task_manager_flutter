import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/widgets/date_picker_timeline/date_picker_timeline.dart';
import 'package:todo_app/views/widgets/todo_card/task_card.dart';

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

  /// TODO: just for debugging purpose
  ///
  /// create a static List of task
  List<Task> taskList = [
    Task(
      userId: 'id 1',
      title: 'Partner Engineer call',
      note: 'Risus in hendrerit gravida rutrum quisque non tellus',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      isCompleted: false,
    ),
    Task(
      userId: 'id 2',
      title: 'UX Design sprint 2',
      note: 'Risus in hendrerit gravida rutrum quisque non tellus',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      isCompleted: true,
    ),
    Task(
      userId: 'id 3',
      title: 'Aerobics session',
      note: 'Risus in hendrerit gravida rutrum quisque non tellus',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      isCompleted: false,
    ),
    Task(
      userId: 'id 4',
      title: 'meeting with the P.O',
      note: 'Risus in hendrerit gravida rutrum quisque non tellus',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      isCompleted: true,
    ),
    Task(
      userId: 'id 5',
      title: 'UX Design sprint',
      note: 'Risus in hendrerit gravida rutrum quisque non tellus',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      isCompleted: false,
    ),
    Task(
      userId: 'id 6',
      title: 'Demo time with the TTL',
      note: 'Risus in hendrerit gravida rutrum quisque non tellus',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      isCompleted: true,
    ),
  ];

  showCreateTaskModal(BuildContext context) {
    Utils.showBottomSheet(context);
  }

  @override
  Widget build(BuildContext context) {
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
                      TodayTasksText(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: FloatingActionButton(
                          backgroundColor: AppColors.primary,
                          splashColor: AppColors.primaryAccent,
                          onPressed: () {
                            showCreateTaskModal(context);
                          },
                          tooltip: 'Create a task',
                          child: Icon(Icons.add, size: 30),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: AppColors.darkGrey),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.69,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                      itemCount: taskList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: TaskCard(
                            task: taskList[index],
                            page: pageStatus,
                          ),
                        );
                      },
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

class TodayTasksText extends StatelessWidget {
  final int countTasks;

  const TodayTasksText({
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
