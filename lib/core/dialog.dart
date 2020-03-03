import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String description;
  final Function onPressed;

  const AppDialog({
    Key key,
    @required this.title,
    @required this.description,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/images/dont-know.gif',
                  height: 120,
                  width: 120,
                ),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                color: AppColors.dark,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: FlatButton(
                color: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                splashColor: AppColors.primary,
                onPressed: onPressed,
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      );
}
