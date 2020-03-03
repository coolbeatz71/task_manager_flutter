import 'package:flutter/material.dart';
import 'package:todo_app/core/dialog.dart';
import 'package:todo_app/helpers/colors.dart';
// import 'package:todo_app/services/auth_key.dart';
import 'package:todo_app/services/firestore.dart';
import 'package:todo_app/views/pages/home/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/views/pages/profile/profile.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AuthKeyService _authKey = AuthKeyService();
    // String authId = _authKey.getKey();
    Stream taskStream = FirestoreService().getTaskByUser(
      'c9ad90ca-7071-41c4-bb42-7945ea330a3a',
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: taskStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => showDialog(
                context: context,
                builder: (_) => AppDialog(
                  title: 'Network error',
                  description:
                      'We are not able to load user data, at this moment...',
                  onPressed: () {
                    Navigator.of(context).pop();
                    return Home();
                  },
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return SpinKitThreeBounce(color: AppColors.primary, size: 30);
          }

          if (data.length == 0) return Home();
          return Profile();
        },
      ),
    );
  }
}
