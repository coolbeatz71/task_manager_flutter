import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String userId;
  final String title;
  final String note;
  final DateTime date;
  final bool isCompleted;

  Task({
    this.userId,
    this.title,
    this.note,
    this.date,
    this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'note': note,
      'date': date,
      'isCompleted': isCompleted,
    };
  }

  Task.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        title = map['title'],
        note = map['note'],
        date = (map['date'] as Timestamp).toDate(),
        isCompleted = map['isCompleted'];
}
