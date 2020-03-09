import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/core/dialog.dart';
import 'package:todo_app/helpers/animation.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/routes/router.gr.dart';
import 'package:todo_app/views/pages/home/home.dart';
import 'package:todo_app/views/widgets/no_data_illustration.dart';
import 'package:todo_app/views/widgets/task_card/task_card.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key key,
    this.dateFilter,
    @required this.taskStream,
    @required this.pageStatus,
  }) : super(key: key);

  final double _borderRadius = 10;
  final Stream taskStream;
  final DateTime dateFilter;
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

        if (taskList.length == 0) {
          switch (pageStatus) {
            case TaskPageStatus.all:
              return Home();
              break;

            default:
              return NoDataIllustration();
          }
        }

        // filter
        if (dateFilter != null) {
          List<Task> filteredTask = taskList.where((item) {
            return Utils.compareDate(item.date, dateFilter);
          }).toList();

          String formattedDate = DateFormat('yyyy MMM dd').format(dateFilter);

          if (filteredTask.length == 0) {
            return NoDataIllustration(
              message: 'No task scheduled for $formattedDate was found',
            );
          }

          taskList = filteredTask;
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: BlocProvider(
                create: (context) => TaskBloc(),
                child: FadeAnimation(
                  0.4,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    onTap: () {
                      Task task = taskList[index];
                      Navigator.of(context).pushNamed(
                        Router.detailsPage,
                        arguments: DetailsArguments(task: task),
                      );
                    },
                    child: TaskCard(
                      borderRadius: _borderRadius,
                      task: taskList[index],
                      page: pageStatus,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
