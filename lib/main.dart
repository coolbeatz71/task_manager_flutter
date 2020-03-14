import 'package:flutter/material.dart';
import 'package:todo_app/routes/router.gr.dart';
import 'package:todo_app/services/auth_key.dart';
import 'package:todo_app/services/notification.dart';
import 'package:todo_app/views/pages/details/details.dart';

Reminder reminder = Reminder();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await reminder.init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    reminder.requestIOSPermissions();
    configureSelectNotificationSubject();
    configureDidReceiveLocalNotificationSubject();
    super.initState();
  }

  void configureSelectNotificationSubject() {
    reminder.selectNotificationSubject.stream.listen(
      (String payload) async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(id: payload),
          ),
        );
      },
    );
  }

  void configureDidReceiveLocalNotificationSubject() {
    reminder.didReceiveLocalNotificationSubject.stream.listen(
      (ReceivedNotification receivedNotification) async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(id: receivedNotification.payload),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthKeyService _authKey = AuthKeyService();
    _authKey.setKey();

    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Router.wrapperPage,
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: Router.navigator.key,
    );
  }

  @override
  void dispose() {
    reminder.dispose();
    super.dispose();
  }
}
