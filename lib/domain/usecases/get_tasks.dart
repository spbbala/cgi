

import 'package:todo/data/models/repositories/task_repository.dart';
import 'package:todo/domain/entities/task.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.getTasks();
  }
}

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> call(Task task) async {
    return await repository.addTask(task);
  }
}

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(Task task) async {
    return await repository.updateTask(task);
  }
}

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteTask(id);
  }
}
