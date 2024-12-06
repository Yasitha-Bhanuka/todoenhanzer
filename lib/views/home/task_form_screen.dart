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
    final padding = clampDouble(size.width * 0.04, 16, 32); // min: 16, max: 32
    final titleFontSize =
        clampDouble(size.width * 0.045, 16, 24); // min: 16, max: 24
    final spacing = clampDouble(size.width * 0.025, 16, 32); // min: 16, max: 32

    // Clamped form width based on device type
    final formWidth = Responsive.isDesktop(context)
        ? clampDouble(size.width * 0.4, 400, 400) // Desktop: min: 400, max: 800
        : Responsive.isTablet(context)
            ? clampDouble(
                size.width * 0.6, 300, 400) // Tablet: min: 300, max: 600
            : clampDouble(
                size.width * 0.9, 280, 400); // Mobile: min: 280, max: 400

    // Clamped button widths
    final buttonWidth =
        clampDouble(size.width * 0.25, 100, 150); // min: 100, max: 200
    final buttonSpacing =
        clampDouble(size.width * 0.02, 8, 8); // min: 8, max: 16

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
                      child: CustomCancelButton(
                        buttonText: "Cancel",
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(width: buttonSpacing),
                    SizedBox(
                      width: buttonWidth,
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
