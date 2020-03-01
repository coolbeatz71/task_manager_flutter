import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/views/pages/profile/active_task/active_task.dart';
import 'package:todo_app/views/pages/profile/all_task/all_task.dart';
import 'package:todo_app/views/pages/profile/completed_task/completed_task.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static int _currentPage = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          AllTask(title: 'All tasks'),
          ActiveTask(title: 'Active tasks'),
          CompletedTask(title: 'Completed tasks'),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 65,
        animationDuration: Duration(milliseconds: 200),
        index: _currentPage,
        items: <Widget>[
          TabIcon(icon: Icons.event_note),
          TabIcon(icon: Icons.event_busy),
          TabIcon(icon: Icons.event_available),
        ],
        color: Colors.black12,
        buttonBackgroundColor: AppColors.secondary,
        backgroundColor: Colors.white,
        onTap: (int index) {
          setState(() {
            _pageController.jumpToPage(index);
            _currentPage = index;
          });
        },
      ),
    );
  }
}

class TabIcon extends StatelessWidget {
  final IconData icon;

  const TabIcon({Key key, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      child: Align(
        alignment: Alignment(0.0, 0.5),
        child: Icon(icon, size: 25, color: AppColors.primary),
      ),
    );
  }
}
