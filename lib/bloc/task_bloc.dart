import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/firestore.dart';

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
    }
  }

  Stream<TaskState> _mapCreateTask(CreateTaskEvent event) async* {
    yield TaskLoading();
    await _firestore.createTask(event.task);
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
}
