import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlflitetodo/core/app_pallete.dart';
import 'package:sqlflitetodo/core/responsive.dart';
import 'package:confetti/confetti.dart';
import 'package:sqlflitetodo/views/widget/custom_button.dart';
import '../providers/theme_provider.dart';
import '../view_models/task_view_model.dart';
import '../models/task.dart';
import 'task_form_screen.dart';

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
      body: Stack(
        children: [
          Consumer<TaskViewModel>(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              decorationThickness:
                                                  2.0, // Increase the thickness of the line
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
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          size: iconSize * 1,
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
                                        scale: size.width * 0.0028,
                                        child: Checkbox(
                                          value: task.status == 1,
                                          onChanged: (value) =>
                                              taskViewModel.updateTaskStatus(
                                                  task, value ?? false),
                                          activeColor:
                                              Theme.of(context).iconTheme.color,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 50, // Increase the number of particles
            emissionFrequency: 0.05, // Increase the emission frequency
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

  void _confirmDeleteTask(BuildContext context, Task task) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              Provider.of<TaskViewModel>(context, listen: false)
                  .deleteTask(task);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
