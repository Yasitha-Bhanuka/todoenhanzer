import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class TaskProvider extends ChangeNotifier {
  final DatabaseService _databaseService;
  List<Task> _tasks = [];

  TaskProvider(this._databaseService) {
    loadTasks();
  }

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _databaseService.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String content) async {
    await _databaseService.addTask(content);
    await loadTasks();
  }

  Future<void> updateTaskStatus(Task task, bool isDone) async {
    await _databaseService.updateTaskStatus(task.id, isDone ? 1 : 0);
    await loadTasks();
  }

  Future<void> updateTaskContent(Task task, String newContent) async {
    await _databaseService.updateTaskContent(task.id, newContent);
    await loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    await _databaseService.deleteTask(task.id);
    await loadTasks();
  }
}
