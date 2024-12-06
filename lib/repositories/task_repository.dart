// repositories/task_repository.dart
import '../models/task.dart';
import '../services/database_service.dart';

class TaskRepository {
  final DatabaseService _databaseService;

  TaskRepository(this._databaseService);

  Future<void> addTask(String content) async {
    await _databaseService.addTask(content);
  }

  Future<List<Task>> getTasks() async {
    return await _databaseService.getTasks();
  }

  Future<void> updateTaskStatus(int id, int status) async {
    await _databaseService.updateTaskStatus(id, status);
  }

  Future<void> deleteTask(int id) async {
    await _databaseService.deleteTask(id);
  }

  Future<void> updateTaskContent(int id, String content) async {
    await _databaseService.updateTaskContent(id, content);
  }
}
