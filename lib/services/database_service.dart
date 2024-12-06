// services/database_service.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _taskTableName = "tasks";
  final String _taskIdColumnName = "id";
  final String _taskContentColumnName = "content";
  final String _tasksStatusColumnName = "status";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          '''CREATE TABLE $_taskTableName(
          $_taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
          $_taskContentColumnName TEXT NOT NULL,
          $_tasksStatusColumnName INTEGER NOT NULL
        )''',
        );
      },
    );
    return database;
  }

  Future<void> addTask(String content) async {
    final db = await database;
    await db.insert(
      _taskTableName,
      {
        _taskContentColumnName: content,
        _tasksStatusColumnName: 0,
      },
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final data = await db.query(_taskTableName);
    return data.map((e) => Task.fromMap(e)).toList();
  }

  Future<void> updateTaskStatus(int id, int status) async {
    final db = await database;
    await db.update(
      _taskTableName,
      {_tasksStatusColumnName: status},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      _taskTableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateTaskContent(int id, String content) async {
    final db = await database;
    await db.update(
      _taskTableName,
      {_taskContentColumnName: content},
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
