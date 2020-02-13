import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task.dart';

class FirestoreService {
  static final FirestoreService _firestoreService = FirestoreService._();
  Firestore _db = Firestore.instance;

  FirestoreService._();
  factory FirestoreService() => _firestoreService;

  Stream<List<Task>> getTaskByUser(String userId) {
    return _db
        .collection('task')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Task.fromMap(doc.data),
              )
              .toList(),
        );
  }
}
