import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/task_controller.dart';
import 'views/task_list_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TaskController()..loadTasks(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      home: TaskListScreen(),
    );
  }
}
