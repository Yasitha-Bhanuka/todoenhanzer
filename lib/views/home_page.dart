import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../view_models/task_view_model.dart';
import '../models/task.dart';
import 'task_form_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TaskFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, taskViewModel, child) {
          return ListView.builder(
            itemCount: taskViewModel.tasks.length,
            itemBuilder: (context, index) {
              final task = taskViewModel.tasks[index];
              return ListTile(
                title: Text(
                  task.content,
                  style: TextStyle(
                    decoration: task.status == 1
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskFormScreen(task: task),
                        ),
                      ),
                    ),
                    Checkbox(
                      value: task.status == 1,
                      onChanged: (value) => taskViewModel.updateTaskStatus(
                        task,
                        value ?? false,
                      ),
                    ),
                  ],
                ),
                onLongPress: () => _confirmDeleteTask(context, task),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDeleteTask(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<TaskViewModel>(context, listen: false)
                  .deleteTask(task);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
