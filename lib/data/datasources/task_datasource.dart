import '../models/task_model.dart';

abstract class TaskDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTaskById(String id);
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}
