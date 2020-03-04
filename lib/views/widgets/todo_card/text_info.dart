import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/views/widgets/todo_card/card_color.dart';

class TextTaskInfo extends StatelessWidget {
  final TaskPageStatus page;
  final String title;
  final String note;
  final bool isCompleted;

  const TextTaskInfo({
    Key key,
    @required this.page,
    @required this.isCompleted,
    @required this.title,
    @required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardColor taskCardColors = CardColor(page, isCompleted);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
            child: Text(
              toBeginningOfSentenceCase(title),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Open Sans',
                color: taskCardColors.texts,
                fontWeight: FontWeight.w800,
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
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
