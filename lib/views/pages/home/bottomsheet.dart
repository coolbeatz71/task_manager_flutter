import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/widgets/forms/task_form.dart';

class BottomSheetContainer extends StatelessWidget {
  final Task task;
  const BottomSheetContainer({
    Key key,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 4, left: 8, right: 8),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Task form',
                        style: TextStyle(
                          color: AppColors.darkGrey,
                          fontSize: 20,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: InkWell(
                        child: Theme(
                          data: new ThemeData(accentColor: Colors.white),
                          child: FloatingActionButton(
                            heroTag: key,
                            elevation: 0,
                            mini: true,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => TaskBloc(),
                child: TaskForm(task: task),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
