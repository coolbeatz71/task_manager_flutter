import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/helpers/utils.dart';
import 'package:todo_app/models/task.dart';

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload; // the id of the task

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

class Reminder {
  int notifId = Utils.randomNumber();

  final FlutterLocalNotificationsPlugin notifPlugin =
      FlutterLocalNotificationsPlugin();

  final BehaviorSubject<ReceivedNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  NotificationAppLaunchDetails notificationAppLaunchDetails;

  init() async {
    notificationAppLaunchDetails =
        await notifPlugin.getNotificationAppLaunchDetails();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (
        int id,
        String title,
        String body,
        String payload,
      ) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
    );

    var initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );

    await notifPlugin.initialize(
      initializationSettings,
      onSelectNotification: (dynamic payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload);
      },
    );
  }

  Future<int> schedule(
    String taskId,
    String taskTitle,
    String taskNote,
    DateTime taskTime,
  ) async {
    DateTime now = DateTime.now();
    DateTime scheduledTime = taskTime.subtract(
      Duration(minutes: 10),
    );

    var vibrationPattern = Int64List(5);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 500;
    vibrationPattern[2] = 2000;
    vibrationPattern[3] = 5000;
    vibrationPattern[4] = 10000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'task_manager_notification',
      'task manager app',
      'flutter task manager app notification',
      importance: Importance.Max,
      priority: Priority.High,
      sound: 'wecker_sound',
      vibrationPattern: vibrationPattern,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'wecker_sound.aiff',
    );

    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );

    // don't schedule the reminder
    // if the scheduled time is 5 minutes
    // before or a the same moment than now
    if (scheduledTime.isAtSameMomentAs(now) ||
        scheduledTime.isBefore(now) ||
        scheduledTime.difference(now).inMinutes <= 5 ||
        taskTime.isAtSameMomentAs(now) ||
        taskTime.isBefore(now)) {
      return null;
    }

    await notifPlugin.schedule(
      notifId,
      taskTitle,
      taskNote,
      scheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      payload: taskId,
    );

    return notifId;
  }

  Future<void> cancel(int notifId) async {
    await notifPlugin.cancel(notifId);
  }

  void requestIOSPermissions() {
    notifPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<int> setup(String id, Task task) async {
    int year = task.date.year;
    int month = task.date.month;
    int day = task.date.day;
    TimeOfDay time = task.time;

    DateTime formatted = Utils.timeToDateTime(
      time,
      year: year,
      month: month,
      day: day,
    );

    return await schedule(
      id,
      task.title,
      task.note,
      formatted,
    );
  }

  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
  }
}
