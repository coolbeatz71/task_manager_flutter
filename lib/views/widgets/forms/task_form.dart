import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({
    Key key,
  }) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: buildInputDecoration(
                false,
                'Enter the task title',
                iconData: Icons.edit,
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: buildInputDecoration(
                      false,
                      'Date',
                      iconData: Icons.calendar_today,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: TextFormField(
                    decoration: buildInputDecoration(
                      false,
                      'Time',
                      iconData: Icons.access_time,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            TextFormField(
              maxLines: 5,
              maxLength: 100,
              decoration: buildInputDecoration(
                true,
                'Enter a little note to describe the task',
              ),
            ),
            SizedBox(height: 25),
            Container(
              child: FlatButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                textColor: Colors.white,
                color: AppColors.primary,
                splashColor: AppColors.primaryAccent,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Submit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(bool isTextArea, String hintText,
          {IconData iconData}) =>
      InputDecoration(
        contentPadding: isTextArea ? EdgeInsets.all(15.0) : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        hintText: hintText,
        prefixIcon: isTextArea ? null : Icon(iconData),
        filled: true,
        fillColor: Colors.grey[100],
      );
}
