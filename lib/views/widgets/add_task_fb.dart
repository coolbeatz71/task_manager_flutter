import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';

class AddTaskFloatingButton extends StatelessWidget {
  const AddTaskFloatingButton({
    Key key,
  }) : super(key: key);

  showCreateTaskModal(BuildContext context) {
    Utils.showBottomSheet(context);
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
        tooltip: 'Create a task',
        child: Icon(Icons.add, size: 30),
      ),
    );
  }
}
