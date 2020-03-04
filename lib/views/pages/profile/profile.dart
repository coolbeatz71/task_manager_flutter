import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
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

  _getPage(int position) {
    switch (position) {
      case 0:
        return AllTask(title: 'All tasks');
        break;
      case 1:
        return ActiveTask(title: 'Active tasks');
        break;
      default:
        return CompletedTask(title: 'Completed tasks');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(child: _getPage(_currentPage)),
      bottomNavigationBar: FancyBottomNavigation(
        key: _bottomNavigationKey,
        inactiveIconColor: AppColors.primary,
        circleColor: AppColors.secondary,
        tabs: [
          TabData(iconData: Icons.event_note, title: "All"),
          TabData(iconData: Icons.event_busy, title: "Active"),
          TabData(iconData: Icons.event_available, title: "Completed")
        ],
        onTabChangedListener: (position) {
          setState(() {
            _currentPage = position;
          });
        },
      ),
    );
  }
}

// FancyBottomNavigation(
//     tabs: [
//         TabData(iconData: Icons.home, title: "Home"),
//         TabData(iconData: Icons.search, title: "Search"),
//         TabData(iconData: Icons.shopping_cart, title: "Basket")
//     ],
//     onTabChangedListener: (position) {
//         setState(() {
//         currentPage = position;
//         });
//     },
// )

// CurvedNavigationBar(
//         key: _bottomNavigationKey,
//         height: 65,
//         animationDuration: Duration(milliseconds: 200),
//         index: _currentPage,
//         items: <Widget>[
//           TabIcon(icon: Icons.event_note),
//           TabIcon(icon: Icons.event_busy),
//           TabIcon(icon: Icons.event_available),
//         ],
//         color: Colors.grey[300],
//         buttonBackgroundColor: AppColors.secondary,
//         backgroundColor: Colors.white,
//         onTap: (int index) {
//           setState(() {
//             _pageController.jumpToPage(index);
//             _currentPage = index;
//           });
//         },
//       ),
//     );
