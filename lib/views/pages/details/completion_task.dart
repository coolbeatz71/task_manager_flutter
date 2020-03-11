import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/core/flushbar.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/models/task.dart';

class TaskCompletionStatus extends StatelessWidget {
  final Task task;

  const TaskCompletionStatus({
    Key key,
    @required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dialogTitle = 'Confirm';
    String completeMsg = 'Do you want to mark the task as completed?';
    String unCompleteMsg = 'Do you want to mark the task as uncompleted?';
    return InkWell(
      onTap: () {
        completeTask(
          context,
          dialogTitle,
          completeMsg,
          unCompleteMsg,
        ).show();
      },
      highlightColor: Colors.grey[100],
      splashColor: Colors.transparent,
      child: Container(
        child: Row(
          children: <Widget>[
            Theme(
              data: ThemeData(accentColor: Colors.white),
              child: FloatingActionButton(
                mini: true,
                elevation: 0,
                heroTag: 'details-completed-task-${task.id}',
                onPressed: null,
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (BuildContext context, TaskState state) {
                    if (state is TaskCompleting) {
                      return Center(
                        child: SpinKitThreeBounce(
                          color: AppColors.primary,
                          size: 14,
                        ),
                      );
                    }

                    return task.isCompleted
                        ? FaIcon(
                            FontAwesomeIcons.solidCheckCircle,
                            color: AppColors.greenAccent,
                            size: 20,
                          )
                        : FaIcon(
                            FontAwesomeIcons.toggleOn,
                            color: Colors.grey[500],
                            size: 20,
                          );
                  },
                ),
              ),
            ),
            Text(
              task.isCompleted ? 'Task completed' : 'Task uncompleted',
              style: TextStyle(
                fontFamily: 'Open Sans',
                color: AppColors.darkGrey,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppFlushBar completeTask(
    BuildContext context,
    String dialogTitle,
    String completeMsg,
    String unCompleteMsg,
  ) {
    return AppFlushBar(
      onPressed: () {
        BlocProvider.of<TaskBloc>(context).add(
          CompleteTaskEvent(task.id, !task.isCompleted),
        );
      },
      padding: 16.2,
      context: context,
      title: dialogTitle,
      message: task.isCompleted ? unCompleteMsg : completeMsg,
      actionText: task.isCompleted ? 'Uncomplete' : 'Complete',
    );
  }
}
