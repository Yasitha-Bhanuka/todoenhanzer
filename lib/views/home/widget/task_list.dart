import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlflitetodo/theme/app_pallete.dart';
import 'package:sqlflitetodo/theme/responsive.dart';
import 'package:sqlflitetodo/models/task.dart';
import 'package:sqlflitetodo/view_models/task_view_model.dart';
import 'package:sqlflitetodo/views/home/task_form_screen.dart';

class TaskList extends StatelessWidget {
  final Size size;
  final double padding;
  final double iconSize;
  final double taskFontSize;
  final Function(BuildContext, Task) onTaskLongPress;

  const TaskList({
    super.key,
    required this.size,
    required this.padding,
    required this.iconSize,
    required this.taskFontSize,
    required this.onTaskLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
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
                    onLongPress: () => onTaskLongPress(context, task),
                    child: AspectRatio(
                      aspectRatio: Responsive.isDesktop(context)
                          ? 8
                          : Responsive.isTablet(context)
                              ? 6
                              : 4,
                      child: TaskItem(
                        task: task,
                        index: index,
                        size: size,
                        padding: padding,
                        iconSize: iconSize,
                        taskFontSize: taskFontSize,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  final int index;
  final Size size;
  final double padding;
  final double iconSize;
  final double taskFontSize;

  const TaskItem({
    super.key,
    required this.task,
    required this.index,
    required this.size,
    required this.padding,
    required this.iconSize,
    required this.taskFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(size.width * 0.03),
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
        borderRadius: BorderRadius.circular(size.width * 0.03),
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
                    '${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: taskFontSize,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
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
                      decorationThickness: 2.0,
                      decorationColor:
                          task.status == 1 ? Pallete.greenColor : null,
                      fontSize: taskFontSize,
                    ),
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.only(left: padding),
                icon: Icon(
                  task.status == 1 ? Icons.delete : Icons.edit,
                  color: Theme.of(context).iconTheme.color,
                  size: iconSize,
                ),
                onPressed: () {
                  if (task.status == 1) {
                    // Implement delete task functionality
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskFormScreen(task: task),
                      ),
                    );
                  }
                },
              ),
              Transform.scale(
                scale: size.width * 0.0028,
                child: Checkbox(
                  value: task.status == 1,
                  onChanged: (value) =>
                      taskViewModel.updateTaskStatus(task, value ?? false),
                  activeColor: Theme.of(context).iconTheme.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
