import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlflitetodo/views/widget/custom_button.dart';
import 'package:sqlflitetodo/views/widget/custom_field.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomField(
                hintText: 'Task Content',
                controller: _contentController,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomCancelButton(
                      buttonText: "Cancel",
                      onTap: () => Navigator.pop(context)),
                  const SizedBox(
                    width: 3,
                  ),
                  CustomSaveButton(
                    buttonText: "Save",
                    onTap: () => _saveTask(),
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
