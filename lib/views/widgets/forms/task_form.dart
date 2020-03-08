import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/core/validation.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';

class TaskForm extends StatefulWidget {
  final Task task;

  const TaskForm({
    Key key,
    this.task,
  }) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  bool _autoValidate = false;
  bool _isButtonDisabled = false;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => utils.selectDate(context, _dateCtrl),
                    child: AbsorbPointer(
                      child: TextFormField(
                        readOnly: true,
                        controller: _dateCtrl,
                        validator: (value) => Validate.getMsg(
                          'date',
                          value,
                        ),
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
                          iconData: Icons.alarm,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            TextFormField(
              maxLines: 3,
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
              child: buildFlatButton(context),
            ),
          ],
        ),
      ),
    );
  }

  FlatButton buildFlatButton(BuildContext context) {
    return FlatButton(
      onPressed: _isButtonDisabled
          ? null
          : () {
              if (_formKey.currentState.validate()) {
                DateTime date = Utils.toDate(_dateCtrl.text);
                TimeOfDay time = Utils.toTime(_timeCtrl.text);

                Task newTask = Task(
                  userId: 'c9ad90ca-7071-41c4-bb42-7945ea330a3a',
                  title: _titleCtrl.text,
                  note: _noteCtrl.text,
                  date: date,
                  time: time,
                  isCompleted: false,
                );

                BlocProvider.of<TaskBloc>(context).add(
                  CreateTaskEvent(newTask),
                );
              } else {
                setState(() => _autoValidate = true);
              }
            },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
      textColor: Colors.white,
      disabledColor: Colors.grey[200],
      color: AppColors.primary,
      child: BlocListener<TaskBloc, TaskState>(
        listener: (BuildContext context, TaskState state) {
          if (state is TaskInitial || state is TaskLoading) {
            setState(() {
              _isButtonDisabled = true;
            });
          } else if (state is TaskSubmitted) {
            setState(() {
              _isButtonDisabled = false;
            });
            Utils.showToast(message: 'Task successfully created');
            Navigator.of(context).pop();
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (BuildContext context, TaskState state) {
              if (state is TaskInitial || state is TaskSubmitted) {
                return Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300,
                  ),
                );
              } else {
                return Center(
                  child: SpinKitThreeBounce(
                    color: AppColors.primary,
                    size: 14,
                  ),
                );
              }
            },
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
