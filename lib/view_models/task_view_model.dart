// view_models/task_view_model.dart
import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;
  List<Task> _tasks = [];

  TaskViewModel(this._taskRepository) {
    loadTasks();
  }

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _taskRepository.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String content) async {
    await _taskRepository.addTask(content);
    await loadTasks();
  }

  Future<void> updateTaskStatus(Task task, bool isDone) async {
    await _taskRepository.updateTaskStatus(task.id, isDone ? 1 : 0);
    await loadTasks();
  }

  Future<void> updateTaskContent(Task task, String newContent) async {
    await _taskRepository.updateTaskContent(task.id, newContent);
    await loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    await _taskRepository.deleteTask(task.id);
    await loadTasks();
  }
}
