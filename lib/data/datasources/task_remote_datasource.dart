import 'package:dio/dio.dart';
import 'package:my_todo_app/data/datasources/task_datasource.dart';

import '../models/task_model.dart';

class TaskRemoteDataSourceImpl implements TaskDataSource {
  final Dio _dio;

  TaskRemoteDataSourceImpl(this._dio);

  // Note: For this example, we're just stubbing these methods since we'll primarily use local storage
  // In a real app, these would make actual API calls

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      // We'd typically do something like:
      // final response = await _dio.get('/tasks');
      // return (response.data as List).map((task) => TaskModel.fromJson(task)).toList();

      // For now, just return an empty list
      // return [];
      throw UnimplementedError();
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    try {
      // final response = await _dio.get('/tasks/$id');
      // return TaskModel.fromJson(response.data);
      throw UnimplementedError();
    } catch (e) {
      throw Exception('Failed to load task');
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      // await _dio.post('/tasks', data: task.toJson());
    } catch (e) {
      throw Exception('Failed to add task');
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      // await _dio.put('/tasks/${task.id}', data: task.toJson());
    } catch (e) {
      throw Exception('Failed to update task');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      // await _dio.delete('/tasks/$id');
    } catch (e) {
      throw Exception('Failed to delete task');
    }
  }
}
