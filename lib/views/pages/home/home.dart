import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/views/pages/home/bottomsheet.dart';
import 'package:todo_app/views/pages/home/btn_create_task.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  showCreateTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BottomSheetContainer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        color: AppColors.secondary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Illustration(),
            TextGetStarted(),
            SizedBox(
              height: 40,
            ),
            BtnCreateTask(onPressed: showCreateTaskModal),
          ],
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

class Illustration extends StatelessWidget {
  const Illustration({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      child: SvgPicture.asset(
        'assets/images/undraw_ideas.svg',
        placeholderBuilder: (context) => SpinKitThreeBounce(
          color: AppColors.primary,
          size: 30,
        ),
        width: 300,
        height: 420,
      ),
    );
  }
}
