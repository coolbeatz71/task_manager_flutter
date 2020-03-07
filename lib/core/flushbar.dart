import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';

class AppFlushBar {
  final BuildContext context;
  final String title;
  final String message;
  final String actionText;
  final double padding;
  final Function onPressed;

  AppFlushBar({
    @required this.context,
    @required this.title,
    @required this.message,
    @required this.actionText,
    @required this.onPressed,
    this.padding = 18.0,
  });

  Flushbar show() {
    return Flushbar(
      icon: Icon(
        Icons.help,
        color: Colors.white,
        size: 35,
      ),
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w900,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w300,
        ),
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: AppColors.darkGrey,
      progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(
        AppColors.primary,
      ),
      padding: EdgeInsets.all(padding),
      shouldIconPulse: true,
      flushbarPosition: FlushbarPosition.BOTTOM,
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.elasticOut,
      reverseAnimationCurve: Curves.linear,
      duration: Duration(seconds: 4),
      mainButton: FlatButton(
        shape: new RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.primary,
            style: BorderStyle.solid,
          ),
          borderRadius: new BorderRadius.circular(10.0),
        ),
        onPressed: () {
          onPressed();
          Navigator.of(context).pop();
        },
        child: Text(
          actionText,
          style: TextStyle(
            color: AppColors.primary,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    )..show(context);
  }
}
