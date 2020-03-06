import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/widgets/todo_card/card_color.dart';
import 'package:todo_app/views/widgets/todo_card/custom_painter.dart';
import 'package:todo_app/views/widgets/todo_card/text_info.dart';
import 'package:todo_app/views/widgets/todo_card/time_board.dart';

class TaskCard extends StatefulWidget {
  final page;
  final Task task;

  const TaskCard({Key key, this.page, this.task}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final double _borderRadius = 10;
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

    Widget buildTaskAction(isCompleted) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Theme(
              data: new ThemeData(accentColor: Colors.transparent),
              child: FloatingActionButton(
                elevation: 0,
                mini: true,
                onPressed: () {
                  print(taskId);
                },
                child: isCompleted
                    ? FaIcon(
                        FontAwesomeIcons.solidCheckCircle,
                        size: 18,
                        color: AppColors.greenAccent,
                      )
                    : FaIcon(
                        FontAwesomeIcons.toggleOn,
                        size: 18,
                        color: Colors.grey[600],
                      ),
              ),
            ),
            Theme(
              data: new ThemeData(accentColor: Colors.transparent),
              child: FloatingActionButton(
                elevation: 0,
                mini: true,
                onPressed: () {
                  print(taskId);
                },
                child: FaIcon(
                  FontAwesomeIcons.solidTrashAlt,
                  size: 18,
                  color: taskCardColors.texts,
                ),
              ),
            ),
          ],
        ),
      );
    }

    LinearGradient buildLinearGradient(TaskPageStatus page, bool taskStatus) {
      if (page == TaskPageStatus.all && !taskStatus) {
        return LinearGradient(
          colors: [colors[0], colors[1]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      }

      return LinearGradient(colors: [colors[0], colors[0]]);
    }

    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            height: _height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              gradient: buildLinearGradient(widget.page, isCompleted),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Visibility(
              maintainSize: false,
              maintainAnimation: true,
              maintainState: true,
              visible: widget.page == TaskPageStatus.all && !isCompleted,
              child: CustomPaint(
                size: Size(82, _height),
                painter: CustomCardShapePainter(
                  _borderRadius,
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
      ),
    );
  }
}
