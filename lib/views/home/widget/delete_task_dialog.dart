import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlflitetodo/models/task.dart';
import 'package:sqlflitetodo/view_models/task_view_model.dart';
import 'package:sqlflitetodo/widgets/custom_button.dart';

class DeleteTaskDialog extends StatelessWidget {
  final Task task;

  const DeleteTaskDialog({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.03),
      ),
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
        CustomCancelButton(
          buttonText: 'Cancel',
          onTap: () => Navigator.pop(context),
        ),
        CustomSaveButton(
          buttonText: 'Delete',
          onTap: () {
            Provider.of<TaskViewModel>(context, listen: false).deleteTask(task);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
