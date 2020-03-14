part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class CreateTaskEvent extends TaskEvent {
  final Task task;

  CreateTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  DeleteTaskEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class CompleteTaskEvent extends TaskEvent {
  final String taskId;
  final bool isCompleted;

  CompleteTaskEvent(this.taskId, this.isCompleted);

  @override
  List<Object> get props => [taskId, isCompleted];
}

class TaskReminderEvent extends TaskEvent {
  final Task task;
  final bool isReminderSet;

  TaskReminderEvent(this.task, this.isReminderSet);

  @override
  List<Object> get props => [task, isReminderSet];
}

class UpdateTaskEvent extends TaskEvent {
  final String taskId;
  final Task task;

  UpdateTaskEvent(this.taskId, this.task);

  @override
  List<Object> get props => [taskId, task];
}
