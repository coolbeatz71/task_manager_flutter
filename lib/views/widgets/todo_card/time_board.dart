import 'package:flutter/material.dart';

class TimeBoard extends StatelessWidget {
  final String hour;
  final String minute; // should contains PM or AM

  const TimeBoard({Key key, this.hour, this.minute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[Text('$hour'), Text('$minute')],
      ),
    );
  }
}
