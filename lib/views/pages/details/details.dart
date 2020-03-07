import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/models/task.dart';

class Details extends StatelessWidget {
  final Task task;
  const Details({Key key, @required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Task details'),
        backgroundColor: AppColors.primary,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Text('details page'),
      ),
    );
  }
}
