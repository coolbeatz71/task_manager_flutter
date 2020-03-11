part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskCompleting extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskReminderSetting extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskDeleting extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskSubmitted extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoaded extends TaskState {
  final List<Task> task;
  const TaskLoaded([this.task = const []]);

  @override
  List<Object> get props => [task];
}

class TaskNotLoaded extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskCompleted extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskReminderSet extends TaskState {
  @override
  List<Object> get props => [];
}
