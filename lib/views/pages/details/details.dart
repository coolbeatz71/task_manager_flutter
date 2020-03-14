import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/core/dialog.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/views/pages/details/completion_task.dart';
import 'package:todo_app/views/pages/details/reminder_status.dart';
import 'package:todo_app/views/pages/details/task_list.dart';
import 'package:todo_app/views/pages/wrapper.dart';
import 'package:todo_app/views/widgets/add_task_fb.dart';
import 'package:todo_app/views/widgets/day_task.dart';

class Details extends StatelessWidget {
  final String id;
  final Task task;

  Details({Key key, this.id, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Task detailsTask;
    FirestoreService firestoreService = FirestoreService();
    Stream taskStream = firestoreService.getTaskById(id ?? task.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Task details'),
        backgroundColor: AppColors.primary,
      ),
      body: StreamBuilder<Object>(
        stream: taskStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var taskData = snapshot.data;
          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => showDialog(
                context: context,
                builder: (_) => AppDialog(
                  title: 'Network error',
                  description:
                      'We are not able to load user data, at this moment...',
                  onPressed: () {
                    Navigator.of(context).pop();
                    return Wrapper();
                  },
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return SpinKitThreeBounce(color: AppColors.primary, size: 30);
          }

          if (taskData != null) detailsTask = Task.fromSnapshot(taskData);

          return BlocProvider(
            create: (context) => TaskBloc(),
            child: BlocListener<TaskBloc, TaskState>(
              listener: (BuildContext context, TaskState state) {
                if (state is TaskCompleted) {
                  Utils.showToast(message: 'Task successfully updated');
                }
              },
              child: Container(
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
                                task: taskData != null ? detailsTask : task,
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
                              TaskCompletionStatus(
                                task: taskData != null ? detailsTask : task,
                              ),
                            ],
                          ),
                        ),
                        TaskReminderStatus(
                          task: taskData != null ? detailsTask : task,
                        ),
                        Divider(),
                        TaskList(
                          task: taskData != null ? detailsTask : task,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
