

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/usecases/get_tasks.dart';
import 'package:todo/presentation/blocs/task_event.dart';
import 'package:todo/presentation/blocs/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<FilterTasksEvent>(_onFilterTasks);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final tasks = await getTasks();
    emit(TaskLoaded(tasks, TaskFilter.all));
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    await addTask(event.task);
    final tasks = await getTasks();
    emit(TaskLoaded(tasks, TaskFilter.all));
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    await updateTask(event.task);
    final tasks = await getTasks();
    emit(TaskLoaded(tasks, TaskFilter.all));
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    await deleteTask(event.id);
    final tasks = await getTasks();
    emit(TaskLoaded(tasks, TaskFilter.all));
  }

  void _onFilterTasks(FilterTasksEvent event, Emitter<TaskState> emit) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      emit(TaskLoaded(currentState.tasks, event.filter));
    }
  }
}
