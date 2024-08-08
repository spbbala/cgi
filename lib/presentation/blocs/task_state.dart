

import 'package:equatable/equatable.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/blocs/task_event.dart';



abstract class TaskState {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final TaskFilter filter;

  const TaskLoaded(this.tasks, this.filter);

  List<Task> get filteredTasks {
    switch (filter) {
      case TaskFilter.completed:
        return tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return tasks.where((task) => !task.isCompleted).toList();
      case TaskFilter.all:
      default:
        return tasks;
    }
  }

  @override
  List<Object> get props => [tasks, filter];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}
