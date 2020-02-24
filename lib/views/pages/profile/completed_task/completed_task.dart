import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';

class CompletedTask extends StatelessWidget {
  final String title;

  const CompletedTask({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: Icon(Icons.event_available),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Text('CompletedTask page'),
      ),
    );
  }
}
