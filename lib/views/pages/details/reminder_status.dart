import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/core/flushbar.dart';
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
    String dialogTitle = 'Confirm';
    String unableReminderMsg = 'Do you want to unable reminder for the task?';
    String disableReminderMsg = 'Do you want to disable reminder for the task?';

    return InkWell(
      onTap: () {
        setTaskReminder(
          context,
          dialogTitle,
          unableReminderMsg,
          disableReminderMsg,
        ).show();
      },
      highlightColor: Colors.grey[100],
      splashColor: Colors.transparent,
      child: Container(
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
                      onPressed: null,
                      mini: true,
                      child: BlocBuilder<TaskBloc, TaskState>(
                        builder: (BuildContext context, TaskState state) {
                          if (state is TaskReminderSetting) {
                            return Center(
                              child: SpinKitThreeBounce(
                                color: AppColors.primary,
                                size: 14,
                              ),
                            );
                          }

                          return task.isReminderSet
                              ? FaIcon(
                                  FontAwesomeIcons.solidBell,
                                  color: AppColors.greenAccent,
                                  size: 20,
                                )
                              : FaIcon(
                                  FontAwesomeIcons.solidBell,
                                  color: AppColors.darkGrey,
                                  size: 20,
                                );
                        },
                      ),
                    ),
                  ),
                  Text(
                    task.isReminderSet
                        ? 'Reminder unabled'
                        : 'Reminder disabled',
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
      ),
    );
  }

  AppFlushBar setTaskReminder(
    BuildContext context,
    String dialogTitle,
    String unableReminderMsg,
    String disableReminderMsg,
  ) {
    return AppFlushBar(
      onPressed: () {
        BlocProvider.of<TaskBloc>(context).add(
          TaskReminderEvent(task, !task.isReminderSet),
        );
      },
      padding: 16.2,
      context: context,
      title: dialogTitle,
      message: task.isReminderSet ? disableReminderMsg : unableReminderMsg,
      actionText: task.isReminderSet ? 'Disable' : 'Unable',
    );
  }
}
