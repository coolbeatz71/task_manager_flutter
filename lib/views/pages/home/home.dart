import 'package:flutter/material.dart';
import 'package:todo_app/helpers/animation.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/views/pages/home/btn_create_task.dart';
import 'package:todo_app/views/widgets/illustration.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  showCreateTaskModal(BuildContext context) {
    Utils.showBottomSheet(context, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeAnimation(
        0.4,
        child: Container(
          padding: EdgeInsets.all(30.0),
          color: AppColors.secondary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Illustration(image: 'assets/images/undraw_ideas.svg'),
              TextGetStarted(),
              SizedBox(height: 40),
              BtnCreateTask(onPressed: showCreateTaskModal),
            ],
          ),
        ),
      ),
    );
  }
}

class TextGetStarted extends StatelessWidget {
  const TextGetStarted({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'To get started with the app, create your first task',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        height: 1.4,
        fontSize: 20,
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
