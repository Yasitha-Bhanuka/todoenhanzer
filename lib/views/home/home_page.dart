import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'package:sqlflitetodo/models/task.dart';
import 'package:sqlflitetodo/providers/theme_provider.dart';
import 'package:sqlflitetodo/view_models/task_view_model.dart';
import 'package:sqlflitetodo/views/home/widget/delete_task_dialog.dart';
import 'package:sqlflitetodo/views/home/widget/task_list.dart';
import 'package:sqlflitetodo/views/home/task_form_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    // Adaptive sizes
    final titleFontSize = size.width * 0.055;
    final subtitleFontSize = size.width * 0.04;
    final iconSize = size.width * 0.055;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _buildAppBarTitle(context, titleFontSize, subtitleFontSize),
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
      floatingActionButton: _buildFloatingActionButton(context, size, iconSize),
      body: Stack(
        children: [
          TaskList(
            size: size,
            padding: size.width * 0.04,
            iconSize: iconSize,
            taskFontSize: size.width * 0.04,
            onTaskLongPress: _confirmDeleteTask,
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 50,
            emissionFrequency: 0.05,
            colors: const [
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarTitle(
      BuildContext context, double titleFontSize, double subtitleFontSize) {
    return Column(
      children: [
        Text(
          'Task List',
          style: TextStyle(fontSize: titleFontSize),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
        Consumer<TaskViewModel>(
          builder: (context, taskViewModel, child) {
            final totalTasks = taskViewModel.tasks.length;
            final incompleteTasks =
                taskViewModel.tasks.where((task) => task.status == 0).length;

            String displayText;
            if (totalTasks == 0) {
              displayText = 'Touch the below plus button 👇';
            } else if (incompleteTasks == 0) {
              displayText = 'All tasks are completed!!! 😍🎊';
              _confettiController.play();
            } else {
              displayText =
                  'Total: $totalTasks  |  Incomplete: $incompleteTasks';
            }

            return Text(
              displayText,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.normal,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton(
      BuildContext context, Size size, double iconSize) {
    return SizedBox(
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
    );
  }

  void _confirmDeleteTask(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => DeleteTaskDialog(task: task),
    );
  }
}
