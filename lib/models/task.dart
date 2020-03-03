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

  Task({
    this.id = '',
    this.userId,
    this.title,
    this.note,
    this.date,
    this.time,
    this.isCompleted,
  });

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'title': title,
      'note': note,
      'date': Utils.dateToString(date),
      'time': Utils.formatTime(time),
      'isCompleted': isCompleted,
    };
  }

  Task.fromSnapshot(DocumentSnapshot snap)
      : id = snap.documentID,
        userId = snap.data['userId'],
        title = snap.data['title'],
        note = snap.data['note'],
        date = Utils.toDate(snap.data['date']),
        time = Utils.toTime(snap.data['time']),
        isCompleted = snap.data['isCompleted'];
}
