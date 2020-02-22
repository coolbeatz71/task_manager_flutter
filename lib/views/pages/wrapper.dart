import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_key.dart';
import 'package:todo_app/services/firestore.dart';
import 'package:todo_app/views/pages/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/views/pages/profile.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthKeyService _authKey = AuthKeyService();
    String authId = _authKey.getKey();
    Stream taskStream = FirestoreService().getTaskByUser(authId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: taskStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (snapshot.hasError) {}

          if (!snapshot.hasData) {
            return SpinKitThreeBounce(
              color: Colors.pink,
              size: 30,
            );
          }

          if (data.length == 0) return Home();
          return Profile();
        },
      ),
    );
  }
}
