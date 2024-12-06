import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlflitetodo/core/responsive.dart';
import 'package:sqlflitetodo/widgets/custom_button.dart';
import 'package:sqlflitetodo/widgets/custom_field.dart';
import '../models/task.dart';
import '../view_models/task_view_model.dart';

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

    // Responsive sizes
    final padding = size.width * 0.04;
    final titleFontSize = size.width * 0.045;
    final spacing = size.height * 0.025;
    final formWidth = Responsive.isDesktop(context)
        ? size.width * 0.4
        : Responsive.isTablet(context)
            ? size.width * 0.6
            : size.width * 0.9;

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
                  child: CustomField(
                    hintText: 'Task Content',
                    controller: _contentController,
                  ),
                ),
                SizedBox(height: spacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: size.width * 0.25,
                      child: CustomCancelButton(
                        buttonText: "Cancel",
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    SizedBox(
                      width: size.width * 0.25,
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
