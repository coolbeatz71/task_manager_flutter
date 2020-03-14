// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:todo_app/views/pages/wrapper.dart';
import 'package:todo_app/views/pages/details/details.dart';
import 'package:todo_app/models/task.dart';

class Router {
  static const wrapperPage = '/';
  static const detailsPage = '/details-page';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.wrapperPage:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute<dynamic>(
          builder: (_) => Wrapper(key: typedArgs),
          settings: settings,
        );
      case Router.detailsPage:
        if (hasInvalidArgs<DetailsArguments>(args)) {
          return misTypedArgsRoute<DetailsArguments>(args);
        }
        final typedArgs = args as DetailsArguments ?? DetailsArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) => Details(
              key: typedArgs.key, id: typedArgs.id, task: typedArgs.task),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//Details arguments holder class
class DetailsArguments {
  final Key key;
  final String id;
  final Task task;
  DetailsArguments({this.key, this.id, this.task});
}
