import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/routes/router.gr.dart';
import 'package:todo_app/services/auth_key.dart';
import 'package:todo_app/services/notification.dart';

Reminder reminder = Reminder();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  reminder.init();
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BehaviorSubject<String> selectNotificationSubject =
      Reminder().selectNotificationSubject;

  @override
  void initState() {
    reminder.requestIOSPermissions();
    configureSelectNotificationSubject();
    super.initState();
  }

  void configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.of(context).pushNamed(
        Router.detailsPage,
        arguments: DetailsArguments(id: payload),
      );
    });
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
    selectNotificationSubject.close();
    reminder.dispose();
    super.dispose();
  }
}
