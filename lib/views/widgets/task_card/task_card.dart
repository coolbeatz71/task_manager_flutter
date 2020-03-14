import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/core/flushbar.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/widgets/task_card/card_color.dart';
import 'package:todo_app/views/widgets/task_card/custom_painter.dart';
import 'package:todo_app/views/widgets/task_card/text_info.dart';
import 'package:todo_app/views/widgets/task_card/time_board.dart';

class TaskCard extends StatefulWidget {
  final page;
  final Task task;
  final double borderRadius;

  const TaskCard({Key key, this.page, this.task, this.borderRadius = 10})
      : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final double _height = 100;

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    /// get the task fields
    String taskId = widget.task.id;
    bool isCompleted = widget.task.isCompleted;
    TimeOfDay time = widget.task.time;
    DateTime date = widget.task.date;

    String hour = Utils.getHour(time);
    String minute = Utils.getMinutes(time);

    /// get colors
    CardColor taskCardColors = CardColor(widget.page, isCompleted);
    List<Color> colors = taskCardColors.background;

    Widget buildTaskAction(bool isCompleted) {
      String dialogTitle = 'Confirm';
      String dialogMsg = 'Do you want to delete this task?';
      String completeMsg = 'Do you want to mark this task as completed?';
      String unCompleteMsg = 'Do you want to mark this task as uncompleted?';

      return BlocListener<TaskBloc, TaskState>(
        listener: (BuildContext context, TaskState state) {
          if (state is TaskCompleted) {
            Utils.showToast(message: 'Task successfully updated');
          }
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Theme(
                data: ThemeData(accentColor: Colors.transparent),
                child: FloatingActionButton(
                  heroTag: 'completed-task-$taskId',
                  elevation: 0,
                  mini: true,
                  onPressed: () {
                    AppFlushBar(
                      onPressed: () {
                        BlocProvider.of<TaskBloc>(context).add(
                          CompleteTaskEvent(taskId, !isCompleted),
                        );
                      },
                      padding: 16.2,
                      context: context,
                      title: dialogTitle,
                      message: isCompleted ? unCompleteMsg : completeMsg,
                      actionText: isCompleted ? 'Uncomplete' : 'Complete',
                    ).show();
                  },
                  child: BlocBuilder<TaskBloc, TaskState>(
                    builder: (BuildContext context, TaskState state) {
                      if (state is TaskCompleting) {
                        return Center(
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 14,
                          ),
                        );
                      }

                      return isCompleted
                          ? FaIcon(
                              FontAwesomeIcons.solidCheckCircle,
                              color: AppColors.greenAccent,
                              size: 18,
                            )
                          : FaIcon(
                              FontAwesomeIcons.toggleOn,
                              color: Colors.grey[500],
                              size: 18,
                            );
                    },
                  ),
                ),
              ),
              Theme(
                data: ThemeData(accentColor: Colors.transparent),
                child: FloatingActionButton(
                  heroTag: 'delete-task-$taskId',
                  elevation: 0,
                  mini: true,
                  onPressed: () {
                    AppFlushBar(
                      onPressed: () {
                        BlocProvider.of<TaskBloc>(context).add(
                          DeleteTaskEvent(taskId),
                        );
                      },
                      padding: 16.2,
                      context: context,
                      title: dialogTitle,
                      message: dialogMsg,
                      actionText: 'Delete',
                    ).show();
                  },
                  child: FaIcon(
                    FontAwesomeIcons.solidTrashAlt,
                    color: taskCardColors.texts,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    LinearGradient buildLinearGradient(TaskPageStatus page, bool taskStatus) {
      if (page == TaskPageStatus.all && !taskStatus) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors[0], colors[1]],
        );
      }

      return LinearGradient(colors: [colors[0], colors[0]]);
    }

    return Stack(
      children: <Widget>[
        Container(
          height: _height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: buildLinearGradient(widget.page, isCompleted),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          child: Visibility(
            maintainSize: false,
            maintainState: true,
            maintainAnimation: true,
            visible: widget.page == TaskPageStatus.all && !isCompleted,
            child: CustomPaint(
              size: Size(82, _height),
              painter: CustomCardShapePainter(
                widget.borderRadius,
                colors[0],
                colors[1],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: TimeBoard(
                  page: widget.page,
                  isCompleted: isCompleted,
                  hour: hour,
                  minute: minute,
                ),
              ),
              Expanded(
                flex: 6,
                child: TextTaskInfo(
                  page: widget.page,
                  isCompleted: isCompleted,
                  title: widget.task.title,
                  note: widget.task.note,
                  date: date,
                ),
              ),
              Expanded(
                flex: 2,
                child: buildTaskAction(isCompleted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
