import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/core/dialog.dart';
import 'package:todo_app/helpers/animation.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/pages/home/home.dart';
import 'package:todo_app/views/widgets/illustration.dart';
import 'package:todo_app/views/widgets/task_card/task_card.dart';

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

        if (taskList.length == 0) {
          switch (pageStatus) {
            case TaskPageStatus.all:
              return Home();
              break;

            default:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Illustration(
                      image: 'assets/images/undraw_no_data.svg',
                      width: 80,
                      height: 180,
                    ),
                    Text(
                      'No task found',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        height: 1.4,
                        fontSize: 20,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
              );
          }
        }

        return ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: BlocProvider(
                create: (context) => TaskBloc(),
                child: FadeAnimation(
                  0.4,
                  child: TaskCard(
                    task: taskList[index],
                    page: pageStatus,
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
