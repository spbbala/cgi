

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/data/models/repositories/task_repository.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/usecases/get_tasks.dart';
import 'package:todo/presentation/blocs/task_bloc.dart';

class MockGetTasks extends Mock implements GetTasks {
  @override
  Future<List<Task>> call() {
    // TODO: implement call
    throw UnimplementedError();
  }

  @override
  // TODO: implement repository
  TaskRepository get repository => throw UnimplementedError();
}

class MockAddTask extends Mock implements AddTask {
  @override
  Future<void> call(Task task) {
    // TODO: implement call
    throw UnimplementedError();
  }

  @override
  // TODO: implement repository
  TaskRepository get repository => throw UnimplementedError();
}

class MockUpdateTask extends Mock implements UpdateTask {}

class MockDeleteTask extends Mock implements DeleteTask {
  @override
  Future<void> call(String id) {
    // TODO: implement call
    throw UnimplementedError();
  }

  @override
  // TODO: implement repository
  TaskRepository get repository => throw UnimplementedError();
}

void main() {
  late TaskBloc taskBloc;
  late MockGetTasks mockGetTasks;
  late MockAddTask mockAddTask;
  late MockUpdateTask mockUpdateTask;
  late MockDeleteTask mockDeleteTask;

  setUp(() {
    mockGetTasks = MockGetTasks();
    mockAddTask = MockAddTask();
    mockUpdateTask = MockUpdateTask();
    mockDeleteTask = MockDeleteTask();
    taskBloc = TaskBloc(
      getTasks: mockGetTasks,
      addTask: mockAddTask,
      updateTask: mockUpdateTask,
      deleteTask: mockDeleteTask,
    );
  });

  test('initial state is TaskLoading', () {
    expect(taskBloc.state, TaskLoading());
  });

  group('LoadTasks', () {
    final tasks = [
      Task(id: '1', title: 'Task 1'),
      Task(id: '2', title: 'Task 2'),
    ];

    test('emits [TaskLoading, TaskLoaded] when tasks are loaded successfully', () {
      when(mockGetTasks()).thenAnswer((_) async => tasks);

      final expected = [
        TaskLoading(),
        TaskLoaded(tasks),
      ];

      expectLater(taskBloc.stream, emitsInOrder(expected));

      taskBloc.add(LoadTasks());
    });
  });

  // Additional tests for AddTaskEvent, UpdateTaskEvent, and DeleteTaskEvent...
}
