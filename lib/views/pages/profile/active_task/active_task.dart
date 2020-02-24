import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';

class ActiveTask extends StatelessWidget {
  final String title;

  const ActiveTask({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: Icon(Icons.event_busy),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Text('ActiveTask page'),
      ),
    );
  }
}
