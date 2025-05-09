import 'dart:convert';

import 'package:my_todo_app/data/datasources/task_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/constants.dart';
import '../models/task_model.dart';

class TaskLocalDataSourceImpl implements TaskDataSource {
  final Future<SharedPreferences> _sharedPreferences;

  TaskLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<List<TaskModel>> getTasks() async {
    final prefs = await _sharedPreferences;
    final tasksString = prefs.getString(AppConstants.tasksKey) ?? '[]';
    final List<dynamic> tasksList = json.decode(tasksString);
    return tasksList.map((task) => TaskModel.fromJson(task)).toList();
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    final tasks = await getTasks();
    final task = tasks.firstWhere((task) => task.id == id);
    return task;
  }

  @override
  Future<void> addTask(TaskModel task) async {
    final prefs = await _sharedPreferences;
    final tasks = await getTasks();
    tasks.add(task);
    await prefs.setString(
      AppConstants.tasksKey,
      json.encode(tasks.map((task) => task.toJson()).toList()),
    );
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final prefs = await _sharedPreferences;
    final tasks = await getTasks();
    final index = tasks.indexWhere((t) => t.id == task.id);

    if (index != -1) {
      tasks[index] = task;
      await prefs.setString(
        AppConstants.tasksKey,
        json.encode(tasks.map((task) => task.toJson()).toList()),
      );
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    final prefs = await _sharedPreferences;
    final tasks = await getTasks();
    tasks.removeWhere((task) => task.id == id);
    await prefs.setString(
      AppConstants.tasksKey,
      json.encode(tasks.map((task) => task.toJson()).toList()),
    );
  }
}
