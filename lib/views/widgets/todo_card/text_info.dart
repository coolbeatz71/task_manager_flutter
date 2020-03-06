import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/views/widgets/todo_card/card_color.dart';

class TextTaskInfo extends StatelessWidget {
  final TaskPageStatus page;
  final String title;
  final String note;
  final bool isCompleted;
  final DateTime date;

  const TextTaskInfo({
    Key key,
    @required this.page,
    @required this.isCompleted,
    @required this.title,
    @required this.note,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardColor taskCardColors = CardColor(page, isCompleted);
    String dateFormat = DateFormat('yyyy MMMM dd').format(date);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 8.0),
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
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Open Sans',
                color: taskCardColors.texts,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
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
