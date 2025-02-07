import 'package:flutter/material.dart';
import '../models/task.dart';
import '../database/database_helper.dart';

class TaskController extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await DatabaseHelper.instance.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await DatabaseHelper.instance.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await DatabaseHelper.instance.deleteTask(id);
    await loadTasks();
  }
}
