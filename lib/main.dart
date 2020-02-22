import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_key.dart';
import 'package:todo_app/views/pages/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthKeyService _authKey = AuthKeyService();
    _authKey.setKey();

    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.transparent,
      ),
      home: Wrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
