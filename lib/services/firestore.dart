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

  Future<DocumentReference> createTask(Task task) async {
    DocumentReference ref = await collection.add(task.toDocument());
    return ref;
  }

  Future<DocumentReference> deleteTask(String id) async {
    DocumentReference ref = collection.document(id);
    await ref.delete();
    return ref;
  }

  Future<void> completeTask(String id, bool field) async {
    DocumentReference ref = collection.document(id);
    await ref.updateData({"isCompleted": field});
    return ref;
  }

  Future<DocumentReference> setTaskReminder(String id, bool field) async {
    DocumentReference ref = collection.document(id);
    await ref.updateData({"isReminderSet": field});
    return ref;
  }

  Future<DocumentReference> updateTask(String id, Task task) async {
    DocumentReference ref = collection.document(id);
    await ref.updateData(task.toDocument());
    return ref;
  }
}
