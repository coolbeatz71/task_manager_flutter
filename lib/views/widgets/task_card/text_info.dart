import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/views/widgets/task_card/card_color.dart';

class TextTaskInfo extends StatelessWidget {
  final TaskPageStatus page;
  final String title;
  final String note;
  final DateTime date;
  final bool isCompleted;

  const TextTaskInfo({
    Key key,
    @required this.page,
    @required this.title,
    @required this.note,
    @required this.date,
    @required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardColor taskCardColors = CardColor(page, isCompleted);
    String dateFormat = DateFormat('yyyy MMMM dd').format(date);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 2.0),
            child: Text(
              toBeginningOfSentenceCase(title),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Open Sans',
                color: taskCardColors.texts,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            child: Text(
              toBeginningOfSentenceCase(note),
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Open Sans',
                color: taskCardColors.texts,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              dateFormat,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Open Sans',
                color: taskCardColors.texts,
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
