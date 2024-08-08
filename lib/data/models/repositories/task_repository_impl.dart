
import 'package:todo/data/models/repositories/task_repository.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/domain/entities/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  List<Task> _tasks = [];

  @override
  Future<List<Task>> getTasks() async {
    return _tasks;
  }

  @override
  Future<void> addTask(Task task) async {
    final taskModel = Task(id: task.id, title: task.title, isCompleted: task.isCompleted);
    _tasks.add(taskModel);
  }

  @override
  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = Task(id: task.id, title: task.title, isCompleted: task.isCompleted);
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
  }
}
