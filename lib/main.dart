import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/repositories/task_repository.dart';
import 'package:todo/data/models/repositories/task_repository_impl.dart';
import 'package:todo/domain/usecases/get_tasks.dart';
import 'package:todo/presentation/blocs/task_bloc.dart';
import 'package:todo/presentation/blocs/task_event.dart';
import 'package:todo/presentation/screens/task_screen.dart';


void main() {
  final taskRepository = TaskRepositoryImpl();
  final getTasks = GetTasks(taskRepository);
  final addTask = AddTask(taskRepository);
  final updateTask = UpdateTask(taskRepository);
  final deleteTask = DeleteTask(taskRepository);

  runApp(MyApp(
    getTasks: getTasks,
    addTask: addTask,
    updateTask: updateTask,
    deleteTask: deleteTask,
  ));
}

class MyApp extends StatelessWidget {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  MyApp({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TaskBloc(
          getTasks: getTasks,
          addTask: addTask,
          updateTask: updateTask,
          deleteTask: deleteTask,
        )..add(LoadTasks()),
        child: TaskScreen(),
      ),
    );
  }
}
