import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/views/pages/details/task_icon.dart';

class TaskListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData leadingIcon;

  const TaskListTile({
    Key key,
    @required this.title,
    @required this.subTitle,
    @required this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TaskIcon(icon: leadingIcon),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Open Sans',
          color: AppColors.darkGrey,
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w300,
          fontSize: 15,
        ),
      ),
      contentPadding: EdgeInsets.all(8.0),
    );
  }
}
