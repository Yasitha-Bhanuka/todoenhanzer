import 'package:flutter/foundation.dart';
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

    // Clamped sizes
    final dialogWidth =
        clampDouble(size.width * 0.8, 280, 400); // min: 280, max: 400
    final borderRadius =
        clampDouble(size.width * 0.03, 8, 16); // min: 8, max: 16
    final titleFontSize =
        clampDouble(size.width * 0.045, 16, 24); // min: 16, max: 24
    final contentFontSize =
        clampDouble(size.width * 0.04, 14, 20); // min: 14, max: 20
    final buttonSpacing =
        clampDouble(size.width * 0.02, 8, 16); // min: 8, max: 16

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: dialogWidth,
          maxHeight:
              clampDouble(size.height * 0.3, 180, 300), // min: 180, max: 300
        ),
        child: Padding(
          padding: EdgeInsets.all(clampDouble(size.width * 0.04, 16, 24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Delete Task',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: buttonSpacing),
              Text(
                'Are you sure you want to delete this task?',
                style: TextStyle(
                  fontSize: contentFontSize,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: buttonSpacing * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: clampDouble(size.width * 0.25, 80, 120),
                    child: CustomCancelButton(
                      buttonText: 'Cancel',
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: buttonSpacing),
                  SizedBox(
                    width: clampDouble(size.width * 0.25, 80, 120),
                    child: CustomSaveButton(
                      buttonText: 'Delete',
                      onTap: () {
                        Provider.of<TaskViewModel>(context, listen: false)
                            .deleteTask(task);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
