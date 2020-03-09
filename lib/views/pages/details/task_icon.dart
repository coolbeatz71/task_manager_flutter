import 'package:flutter/material.dart';

class TaskIcon extends StatelessWidget {
  final IconData icon;
  const TaskIcon({
    Key key,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Icon(icon),
    );
  }
}
