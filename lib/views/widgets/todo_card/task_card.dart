import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';
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
    /// get the task isCompleted field
    bool isCompleted = widget.task.isCompleted;
    TimeOfDay time = widget.task.time;

    String hour = Utils.getHour(time);
    String minute = Utils.getMinutes(time);

    /// get colors
    TaskCardColor taskCardColors = TaskCardColor(widget.page, isCompleted);
    List<Color> colors = taskCardColors.getBackground();

    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            height: _height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              gradient: (widget.page == TaskPageStatus.all && isCompleted)
                  ? LinearGradient(colors: [colors[0], colors[0]])
                  : LinearGradient(
                      colors: [colors[0], colors[1]],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
              visible: !isCompleted,
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
                    isCompleted: isCompleted,
                    title: widget.task.title,
                    note: widget.task.note,
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

  Widget buildTaskAction(isCompleted) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Switch(
            value: isCompleted,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeColor: AppColors.secondary,
          ),
          Theme(
            data: new ThemeData(accentColor: Colors.transparent),
            child: FloatingActionButton(
              elevation: 0,
              mini: true,
              onPressed: () {},
              child: FaIcon(
                FontAwesomeIcons.solidTrashAlt,
                size: 22,
                color: (isCompleted ? Colors.black38 : Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextTaskInfo extends StatelessWidget {
  final String title;
  final String note;
  final bool isCompleted;
  const TextTaskInfo({
    Key key,
    @required this.isCompleted,
    @required this.title,
    @required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
            child: Text(
              toBeginningOfSentenceCase(title),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Open Sans',
                color: (isCompleted) ? Colors.black38 : Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            child: Text(
              toBeginningOfSentenceCase(note),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Open Sans',
                color: (isCompleted) ? Colors.black38 : Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TaskCardColor {
  final TaskPageStatus page;
  final bool isCompleted;

  TaskCardColor(this.page, this.isCompleted);

  List<Color> getBackground() {
    switch (page) {
      case TaskPageStatus.all:
        return isCompleted
            ? [Color(0xFFEBEBE4), Colors.black45]
            : [AppColors.lightBlue, AppColors.primary];
        break;
      case TaskPageStatus.completed:
        return [Colors.black45, Colors.white];
        break;
      default:
        return [Colors.white, AppColors.primary];
        break;
    }
  }
}
