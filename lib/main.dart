import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'view_models/task_view_model.dart';
import 'views/splash_screen.dart';
import 'services/database_service.dart';
import 'repositories/task_repository.dart';

void main() {
  final databaseService = DatabaseService.instance;
  final taskRepository = TaskRepository(databaseService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) => TaskViewModel(taskRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: themeProvider.currentTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
