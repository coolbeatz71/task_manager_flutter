import 'package:flutter/material.dart';
import 'package:todo_app/core/validation.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({
    Key key,
  }) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  bool _autoValidate = false;

  final _formKey = GlobalKey<FormState>();
  final Utils utils = Utils();

  /// Text controllers
  TextEditingController _titleCtrl;
  TextEditingController _noteCtrl;
  TextEditingController _dateCtrl;
  TextEditingController _timeCtrl;

  @override
  void initState() {
    super.initState();

    _titleCtrl = TextEditingController(text: '');
    _noteCtrl = TextEditingController(text: '');
    _dateCtrl = TextEditingController(text: '');
    _timeCtrl = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _titleCtrl,
              validator: (value) => Validate.getMsg('title', value),
              decoration: buildInputDecoration(
                false,
                'Enter the task title',
                iconData: Icons.edit,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => utils.selectDate(context, _dateCtrl),
                    child: AbsorbPointer(
                      child: TextFormField(
                        readOnly: true,
                        controller: _dateCtrl,
                        validator: (value) => Validate.getMsg('date', value),
                        decoration: buildInputDecoration(
                          false,
                          'Date',
                          iconData: Icons.calendar_today,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () => utils.selectTime(context, _timeCtrl),
                    child: AbsorbPointer(
                      child: TextFormField(
                        readOnly: true,
                        controller: _timeCtrl,
                        validator: (value) => Validate.getDateTimeMsg(
                          'time',
                          value,
                        ),
                        decoration: buildInputDecoration(
                          false,
                          'Time',
                          iconData: Icons.access_time,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            TextFormField(
              maxLines: 5,
              maxLength: 100,
              controller: _noteCtrl,
              validator: (value) => Validate.getMsg('note', value),
              decoration: buildInputDecoration(
                true,
                'Enter a little note to describe the task',
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: buildFlatButton(),
            ),
          ],
        ),
      ),
    );
  }

  FlatButton buildFlatButton() {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          print('valid');
        } else {
          print('invalid');
          setState(() => _autoValidate = true);
        }
      },
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: hintText,
        prefixIcon: isTextArea ? null : Icon(iconData),
        filled: true,
        fillColor: Colors.grey[100],
      );
}
