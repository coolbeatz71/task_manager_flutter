import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/helpers/utils.dart';

class Task {
  final String id;
  final String userId;
  final String title;
  final String note;
  final DateTime date;
  final TimeOfDay time;
  final bool isCompleted;
  final bool isReminderSet;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    this.id = '',
    this.userId,
    this.title,
    this.note,
    this.date,
    this.time,
    this.isCompleted,
    this.isReminderSet,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'title': title,
      'note': note,
      'date': Utils.dateToString(date),
      'time': Utils.formatTime(time),
      'isCompleted': isCompleted,
      'isReminderSet': isReminderSet,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Task.fromSnapshot(DocumentSnapshot snap)
      : id = snap.documentID,
        userId = snap.data['userId'],
        title = snap.data['title'],
        note = snap.data['note'],
        date = Utils.toDate(snap.data['date']),
        time = Utils.toTime(snap.data['time']),
        isCompleted = snap.data['isCompleted'],
        isReminderSet = snap.data['isReminderSet'],
        createdAt = (snap.data['createdAt'] as Timestamp).toDate(),
        updatedAt = (snap.data['updatedAt'] as Timestamp).toDate();
}
