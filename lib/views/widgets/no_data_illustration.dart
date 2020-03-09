import 'package:flutter/material.dart';
import 'package:todo_app/views/widgets/illustration.dart';

class NoDataIllustration extends StatelessWidget {
  final String message;

  const NoDataIllustration({
    Key key,
    this.message = 'No task found',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Illustration(
            image: 'assets/images/undraw_no_data.svg',
            width: 80,
            height: 180,
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                height: 1.4,
                fontSize: 18,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
