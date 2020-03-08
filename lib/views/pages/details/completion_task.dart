import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/models/task.dart';

class TaskCompletionStatus extends StatelessWidget {
  const TaskCompletionStatus({
    Key key,
    @required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            task.isCompleted ? 'Task completed' : 'Task uncompleted',
            style: TextStyle(
              fontFamily: 'Open Sans',
              color: AppColors.darkGrey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
