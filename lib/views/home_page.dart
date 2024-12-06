import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlflitetodo/core/app_pallete.dart';
import 'package:sqlflitetodo/core/responsive.dart';
import '../providers/theme_provider.dart';
import '../view_models/task_view_model.dart';
import '../models/task.dart';
import 'task_form_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    // Adaptive sizes
    final titleFontSize = size.width * 0.055;
    final subtitleFontSize = size.width * 0.04;
    final taskFontSize = size.width * 0.04;
    final iconSize = size.width * 0.055;
    final padding = size.width * 0.04;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Task List',
              style: TextStyle(fontSize: titleFontSize),
            ),
            SizedBox(height: size.height * 0.005),
            Consumer<TaskViewModel>(
              builder: (context, taskViewModel, child) {
                final totalTasks = taskViewModel.tasks.length;
                final incompleteTasks = taskViewModel.tasks
                    .where((task) => task.status == 0)
                    .length;

                return Text(
                  (incompleteTasks == 0 && totalTasks > 0)
                      ? 'All tasks are completed!!!'
                      : 'Total: $totalTasks  |  Incomplete: $incompleteTasks',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.normal,
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).iconTheme.color,
              size: iconSize,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: size.width * 0.16,
        width: size.width * 0.16,
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskFormScreen()),
          ),
          backgroundColor: Theme.of(context).iconTheme.color,
          shape: const CircleBorder(),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: iconSize,
          ),
        ),
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, taskViewModel, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return ListView.builder(
                padding: EdgeInsets.all(padding),
                itemCount: taskViewModel.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskViewModel.tasks[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: padding * 0.5),
                    child: GestureDetector(
                      onLongPress: () => _confirmDeleteTask(context, task),
                      child: AspectRatio(
                        aspectRatio: Responsive.isDesktop(context)
                            ? 8
                            : Responsive.isTablet(context)
                                ? 6
                                : 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                                BorderRadius.circular(size.width * 0.03),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: size.width * 0.01,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.03),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: padding,
                                vertical: padding * 0.3,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: size.width * 0.06,
                                    height: size.width * 0.06,
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      child: Text(
                                        '${taskViewModel.tasks.indexOf(task) + 1}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: taskFontSize,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: padding),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        task.content,
                                        style: TextStyle(
                                          decoration: task.status == 1
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          decorationColor: task.status == 1
                                              ? Pallete.greenColor
                                              : null,
                                          fontSize: taskFontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.only(left: padding),
                                    icon: Icon(
                                      task.status == 1
                                          ? Icons.delete
                                          : Icons.edit,
                                      color: Theme.of(context).iconTheme.color,
                                      size: iconSize * 0.8,
                                    ),
                                    onPressed: () {
                                      if (task.status == 1) {
                                        _confirmDeleteTask(context, task);
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TaskFormScreen(task: task),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Transform.scale(
                                    scale: size.width * 0.002,
                                    child: Checkbox(
                                      value: task.status == 1,
                                      onChanged: (value) =>
                                          taskViewModel.updateTaskStatus(
                                              task, value ?? false),
                                      activeColor:
                                          Theme.of(context).iconTheme.color,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDeleteTask(BuildContext context, Task task) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Task',
          style: TextStyle(
            fontSize: size.width * 0.045,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this task?',
          style: TextStyle(
            fontSize: size.width * 0.04,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: size.width * 0.035,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<TaskViewModel>(context, listen: false)
                  .deleteTask(task);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(
                fontSize: size.width * 0.035,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
