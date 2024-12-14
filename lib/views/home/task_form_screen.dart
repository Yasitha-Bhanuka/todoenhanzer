import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlflitetodo/theme/responsive.dart';
import 'package:sqlflitetodo/widgets/custom_button.dart';
import 'package:sqlflitetodo/widgets/custom_field.dart';
import '../../models/task.dart';
import '../../view_models/task_view_model.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;

  const TaskFormScreen({super.key, this.task});

  @override
  TaskFormScreenState createState() => TaskFormScreenState();
}

class TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController =
        TextEditingController(text: widget.task?.content ?? '');
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
      if (widget.task == null) {
        taskViewModel.addTask(_contentController.text);
      } else {
        taskViewModel.updateTaskContent(widget.task!, _contentController.text);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Responsive sizes with clamped values
    final padding = Responsive.isDesktop(context)
        ? clampDouble(size.width * 0.04, 24, 30) // Desktop: min: 24, max: 32
        : Responsive.isTablet(context)
            ? clampDouble(size.width * 0.04, 20, 26) // Tablet: min: 20, max: 28
            : clampDouble(
                size.width * 0.04, 16, 24); // Mobile: min: 16, max: 24

    final titleFontSize = Responsive.isDesktop(context)
        ? clampDouble(size.width * 0.045, 20, 24) // Desktop: min: 20, max: 24
        : Responsive.isTablet(context)
            ? clampDouble(
                size.width * 0.045, 18, 22) // Tablet: min: 18, max: 22
            : clampDouble(
                size.width * 0.045, 16, 20); // Mobile: min: 16, max: 20

    final spacing = Responsive.isDesktop(context)
        ? clampDouble(size.width * 0.025, 24, 30) // Desktop: min: 24, max: 32
        : Responsive.isTablet(context)
            ? clampDouble(
                size.width * 0.025, 20, 28) // Tablet: min: 20, max: 28
            : clampDouble(
                size.width * 0.025, 16, 24); // Mobile: min: 16, max: 24

    // Clamped form width based on device type
    final formWidth = Responsive.isDesktop(context)
        ? clampDouble(
            size.width * 0.8, 400, 1080) // Desktop: min: 400, max: 800
        : Responsive.isTablet(context)
            ? clampDouble(
                size.width * 0.6, 300, 800) // Tablet: min: 300, max: 600
            : clampDouble(
                size.width * 0.9, 280, 400); // Mobile: min: 280, max: 400

    // Clamped button widths
    final buttonWidth = Responsive.isDesktop(context)
        ? clampDouble(
            size.width * 0.15, 100, 300) // Desktop: min: 100, max: 200
        : Responsive.isTablet(context)
            ? clampDouble(
                size.width * 0.2, 100, 150) // Tablet: min: 100, max: 150
            : clampDouble(
                size.width * 0.25, 100, 150); // Mobile: min: 100, max: 150

    // Clamped button spacing
    final buttonSpacing = Responsive.isDesktop(context)
        ? clampDouble(size.width * 0.02, 8, 16) // Desktop: min: 8, max: 16
        : Responsive.isTablet(context)
            ? clampDouble(size.width * 0.02, 8, 14) // Tablet: min: 8, max: 12
            : clampDouble(size.width * 0.02, 8, 8); // Mobile: min: 8, max: 8

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task == null ? 'Add Task' : 'Edit Task',
          style: TextStyle(fontSize: titleFontSize),
        ),
      ),
      body: Center(
        child: Container(
          width: formWidth,
          // height: formWidth / 2,
          padding: EdgeInsets.all(padding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: Responsive.isDesktop(context) ? 6 : 4,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200, // Maximum height for input field
                    ),
                    child: CustomField(
                      hintText: 'Task Content',
                      controller: _contentController,
                    ),
                  ),
                ),
                SizedBox(height: spacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: buttonWidth,
                      height: buttonWidth / 2,
                      child: CustomCancelButton(
                        buttonText: "Cancel",
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(width: buttonSpacing),
                    SizedBox(
                      width: buttonWidth,
                      height: buttonWidth / 2,
                      child: CustomSaveButton(
                        buttonText: "Save",
                        onTap: _saveTask,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
