import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task.dart';

class FirestoreService {
  static final FirestoreService _firestoreService = FirestoreService._();
  static final Firestore _db = Firestore.instance;

  FirestoreService._();
  factory FirestoreService() => _firestoreService;

  CollectionReference collection = _db.collection('task');

  Stream<List<Task>> getTaskByUser(String userId) {
    return collection
        .where("userId", isEqualTo: userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.documents.map(
            (doc) {
              return Task.fromSnapshot(doc);
            },
          ).toList(),
        );
  }

  Stream<DocumentSnapshot> getTaskById(String id) =>
      collection.document(id).snapshots();

  Stream<List<Task>> getTaskByStatus(String userId, {bool isCompleted = true}) {
    return collection
        .where("userId", isEqualTo: userId)
        .where("isCompleted", isEqualTo: isCompleted)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.documents.map(
            (doc) {
              return Task.fromSnapshot(doc);
            },
          ).toList(),
        );
  }

  Future<void> createTask(Task task) async => collection.add(task.toDocument());

  Future<void> deleteTask(String id) async => collection.document(id).delete();

  Future<void> completeTask(String id, bool field) =>
      collection.document(id).updateData(
        {"isCompleted": field},
      );

  Future<void> setTaskReminder(String id, bool field) =>
      collection.document(id).updateData(
        {"isReminderSet": field},
      );

  Future<void> updateTask(String id, Task task) =>
      collection.document(id).updateData(
            task.toDocument(),
          );
}
