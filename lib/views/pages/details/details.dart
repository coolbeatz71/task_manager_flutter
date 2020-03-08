import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
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
                      Container(
                        child: Row(
                          children: <Widget>[
                            Theme(
                              data: ThemeData(accentColor: Colors.white),
                              child: FloatingActionButton(
                                heroTag: 'details-completed-task-${task.id}',
                                elevation: 0,
                                onPressed: () {},
                                mini: true,
                                child: task.isCompleted
                                    ? FaIcon(
                                        FontAwesomeIcons.solidCheckCircle,
                                        color: AppColors.greenAccent,
                                        size: 25,
                                      )
                                    : FaIcon(
                                        FontAwesomeIcons.toggleOn,
                                        color: Colors.grey[500],
                                        size: 25,
                                      ),
                              ),
                            ),
                            Text(
                              task.isCompleted
                                  ? 'Task completed'
                                  : 'Task uncompleted',
                              style: titleTextStyle(),
                            ),
                          ],
                        ),
                      ),
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
                Container(
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
                                  size: 25,
                                ),
                              ),
                            ),
                            Text(
                              'Reminder activated',
                              style: titleTextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0,
                  ),
                  height: 420,
                  child: ListView(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: <Widget>[
                        ListTile(
                          leading: buildLeader(Icons.assignment),
                          title: Text(
                            'Title',
                            style: titleTextStyle(),
                          ),
                          subtitle: Text(
                            task.title,
                            style: valueTextStyle(),
                          ),
                          contentPadding: EdgeInsets.all(5.0),
                        ),
                        ListTile(
                          leading: buildLeader(Icons.description),
                          title: Text(
                            'Note',
                            style: titleTextStyle(),
                          ),
                          subtitle: Text(
                            task.note,
                            style: valueTextStyle(),
                          ),
                          contentPadding: EdgeInsets.all(5.0),
                        ),
                        ListTile(
                          leading: buildLeader(Icons.calendar_today),
                          title: Text(
                            'Date',
                            style: titleTextStyle(),
                          ),
                          subtitle: Text(
                            DateFormat('yyyy MMMM dd').format(task.date),
                            style: valueTextStyle(),
                          ),
                          contentPadding: EdgeInsets.all(5.0),
                        ),
                        ListTile(
                          leading: buildLeader(Icons.alarm),
                          title: Text(
                            'Time',
                            style: titleTextStyle(),
                          ),
                          subtitle: Text(
                            Utils.formatTime(task.time),
                            style: valueTextStyle(),
                          ),
                          contentPadding: EdgeInsets.all(5.0),
                        ),
                      ],
                    ).toList(),
                  ), //
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildLeader(IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Icon(icon),
    );
  }

  TextStyle valueTextStyle() {
    return TextStyle(
      fontFamily: 'Open Sans',
      fontWeight: FontWeight.w300,
      fontSize: 18,
    );
  }

  TextStyle titleTextStyle() {
    return TextStyle(
      fontFamily: 'Open Sans',
      color: AppColors.darkGrey,
      fontSize: 15,
    );
  }
}
