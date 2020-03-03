import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/core/dialog.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/pages/home/home.dart';
import 'package:todo_app/views/widgets/todo_card/task_card.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key key,
    @required this.taskStream,
    @required this.pageStatus,
  }) : super(key: key);

  final Stream taskStream;
  final TaskPageStatus pageStatus;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: taskStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Task> taskList = snapshot.data;

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
                  return Home();
                },
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: SpinKitThreeBounce(
              color: AppColors.primary,
              size: 30,
            ),
          );
        }

        if (taskList.length == 0) return Home();

        return ListView.builder(
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
        );
      },
    );
  }
}
