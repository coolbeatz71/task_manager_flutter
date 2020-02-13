import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/views/widgets/forms/task_form.dart';

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
        color: Color(0xFF241B50),
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

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 30.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Task form',
                        style: TextStyle(
                          color: Color(0xFF504D53),
                          fontSize: 24,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Flexible(
                      child: InkWell(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0x50000000),
                            fontFamily: 'Open Sans',
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
              TaskForm(),
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
        height: 1.5,
        letterSpacing: 1.2,
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
          color: Colors.pink,
          size: 30,
        ),
        width: 300,
        height: 420,
      ),
    );
  }
}

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
        borderRadius: new BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
      textColor: Colors.white,
      color: Color(0xFFEC407A),
      splashColor: Color(0xFFAD1457),
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
