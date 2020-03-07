import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:todo_app/views/pages/profile/active_task/active_task.dart';
import 'package:todo_app/views/pages/profile/all_task/all_task.page.dart';
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

  final List<FFNavigationBarItem> items = [
    FFNavigationBarItem(iconData: Icons.event_note, label: "All"),
    FFNavigationBarItem(iconData: Icons.event_busy, label: "Active"),
    FFNavigationBarItem(iconData: Icons.event_available, label: "Completed"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: FFNavigationBar(
        key: _bottomNavigationKey,
        selectedIndex: _currentPage,
        theme: FFNavigationBarTheme(
          selectedItemIconColor: AppColors.primary,
          selectedItemBorderColor: AppColors.secondary,
          selectedItemBackgroundColor: AppColors.secondary,
          selectedItemLabelColor: AppColors.secondary,
        ),
        items: items,
        onSelectTab: (int index) {
          setState(() {
            _pageController.jumpToPage(index);
            _currentPage = index;
          });
        },
      ),
    );
  }
}
