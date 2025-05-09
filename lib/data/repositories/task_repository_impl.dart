import 'package:my_todo_app/data/datasources/task_datasource.dart';

import '../../core/network/network_info.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../datasources/task_remote_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource localDataSource;
  final TaskDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TaskRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Task>> getTasks() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTasks = await remoteDataSource.getTasks();
        // Ideally, we would save these to local cache here
        return remoteTasks;
      } catch (e) {
        // If remote fails, fall back to local
        return localDataSource.getTasks();
      }
    } else {
      return localDataSource.getTasks();
    }
  }

  @override
  Future<Task> getTaskById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.getTaskById(id);
      } catch (e) {
        return localDataSource.getTaskById(id);
      }
    } else {
      return localDataSource.getTaskById(id);
    }
  }

  @override
  Future<void> addTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);

    await localDataSource.addTask(taskModel);

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addTask(taskModel);
      } catch (e) {
        // Handle error or retry later
      }
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);

    await localDataSource.updateTask(taskModel);

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateTask(taskModel);
      } catch (e) {
        // Handle error or retry later
      }
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    await localDataSource.deleteTask(id);

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteTask(id);
      } catch (e) {
        // Handle error or retry later
      }
    }
  }
}
