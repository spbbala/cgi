

import 'package:equatable/equatable.dart';
import 'package:todo/domain/entities/task.dart';



 class TaskEvent {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent(this.id);

  @override
  List<Object> get props => [id];
}

class FilterTasksEvent extends TaskEvent {
  final TaskFilter filter;

  const FilterTasksEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

enum TaskFilter { all, completed, pending }

