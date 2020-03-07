import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/helpers/colors.dart';

class BtnCreateTask extends StatelessWidget {
  final Function onPressed;
  const BtnCreateTask({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
      textColor: Colors.white,
      color: AppColors.primary,
      icon: FaIcon(
        FontAwesomeIcons.plus,
        size: 14,
      ),
      label: Text(
        'New task',
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w300,
        ),
      ),
      onPressed: () {
        onPressed(context);
      },
    );
  }
}
