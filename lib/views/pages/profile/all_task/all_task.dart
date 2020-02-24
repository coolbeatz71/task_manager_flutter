import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';

class AllTask extends StatelessWidget {
  final String title;

  const AllTask({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primary,
        leading: Icon(Icons.event_note),
        actions: <Widget>[
          IconButton(
            tooltip: 'Mark All as done',
            icon: Icon(Icons.playlist_add_check),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text('All Task page'),
      ),
    );
  }
}
