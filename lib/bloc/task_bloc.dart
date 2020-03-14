import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/firestore.dart';
import 'package:todo_app/services/notification.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FirestoreService _firestore = FirestoreService();

  @override
  TaskState get initialState => TaskInitial();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is CreateTaskEvent) {
      yield* _mapCreateTask(event);
    } else if (event is DeleteTaskEvent) {
      yield* _mapDeleteTask(event);
    } else if (event is CompleteTaskEvent) {
      yield* _mapCompleteTask(event);
    } else if (event is UpdateTaskEvent) {
      yield* _mapUpdateTask(event);
    } else if (event is TaskReminderEvent) {
      yield* _mapTaskReminder(event);
    }
  }

  Stream<TaskState> _mapCreateTask(CreateTaskEvent event) async* {
    yield TaskLoading();
    DocumentReference ref = await _firestore.createTask(event.task);

    // schedule reminder
    if (event.task.isReminderSet == true)
      await Reminder().setup(
        ref.documentID,
        event.task,
      );
    yield TaskSubmitted();
  }

  Stream<TaskState> _mapDeleteTask(DeleteTaskEvent event) async* {
    yield TaskDeleting();
    await _firestore.deleteTask(event.taskId);
  }

  Stream<TaskState> _mapCompleteTask(CompleteTaskEvent event) async* {
    yield TaskCompleting();
    await _firestore.completeTask(event.taskId, event.isCompleted);
    yield TaskCompleted();
  }

  Stream<TaskState> _mapTaskReminder(TaskReminderEvent event) async* {
    yield TaskReminderSetting();
    await _firestore.setTaskReminder(event.task.id, event.isReminderSet);

    // schedule reminder
    if (event.isReminderSet == true)
      await Reminder().setup(
        event.task.id,
        event.task,
      );
    yield TaskReminderSet();
  }

  Stream<TaskState> _mapUpdateTask(UpdateTaskEvent event) async* {
    yield TaskLoading();
    await _firestore.updateTask(event.taskId, event.task);

    // schedule reminder
    if (event.task.isReminderSet == true)
      await Reminder().setup(
        event.taskId,
        event.task,
      );
    yield TaskSubmitted();
  }
}
