import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';

class AddTaskFloatingButton extends StatelessWidget {
  final IconData icon;
  final Task task;
  final TaskPageStatus fromPage;

  AddTaskFloatingButton({
    Key key,
    this.task,
    this.icon = Icons.add,
    @required this.fromPage,
  }) : super(key: key);

  showCreateTaskModal(BuildContext context) {
    Utils.showBottomSheet(context, task);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: FloatingActionButton(
        heroTag: key,
        backgroundColor: AppColors.primary,
        onPressed: () {
          showCreateTaskModal(context);
        },
        tooltip:
            (fromPage == TaskPageStatus.details) ? 'Edit task' : 'Create task',
        child: Icon(icon, size: 30),
      ),
    );
  }
}
